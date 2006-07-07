Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWGGUfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWGGUfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWGGUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:35:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751245AbWGGUfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:35:36 -0400
Date: Fri, 7 Jul 2006 16:35:31 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org, se.witt@gmx.de
Subject: Re: lost cpufreq (Re: Linux v2.6.18-rc1)
Message-ID: <20060707203531.GA3421@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, se.witt@gmx.de
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <20060707175239.GB7648@irc.pl> <20060707190739.GB5818@redhat.com> <20060707202706.GD7648@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707202706.GD7648@irc.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 10:27:06PM +0200, Tomasz Torcz wrote:
 > On Fri, Jul 07, 2006 at 03:07:39PM -0400, Dave Jones wrote:
 > > On Fri, Jul 07, 2006 at 07:52:39PM +0200, Tomasz Torcz wrote:
 > >  > On Wed, Jul 05, 2006 at 09:26:35PM -0700, Linus Torvalds wrote:
 > >  > > 
 > >  > > Ok,
 > >  > >  the merge window for 2.6.18 is closed, and -rc1 is out there
 > >  > 
 > >  >   ... and cpufreq-nforce2.ko fails to work. Module can't be loaded:
 > >  > FATAL: Error inserting cpufreq_nforce2
 > >  > (/lib/modules/2.6.18-rc1/kernel/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.ko):
 > >  > Device or resource busy
 > >  > 
 > >  >   Here's relevant difference between dmesg of 2.6.17 and 2.6.18-rc1:
 > >  > 
 > >  > @@ -244,7 +240,6 @@
 > >  >  lp: driver loaded but no devices found
 > >  >  cpufreq: Detected nForce2 chipset revision C1
 > >  >  cpufreq: FSB changing is maybe unstable and can lead to crashes and data loss.
 > >  > -cpufreq: FSB currently at 165 MHz, FID 10.5
 > >  >  usbcore: registered new driver usbfs
 > >  >  usbcore: registered new driver hub
 > > 
 > > Does it work again if you apply this patch with -R ?
 > 
 >   No.

That's puzzling, as the only other changes to cpufreq-nforce are completely cosmetic
(whitespace and the like).

		Dave

-- 
http://www.codemonkey.org.uk

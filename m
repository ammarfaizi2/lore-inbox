Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWCVPVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWCVPVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCVPVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:21:50 -0500
Received: from tim.rpsys.net ([194.106.48.114]:4260 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751305AbWCVPVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:21:47 -0500
Subject: Re: ucb1x00 audio & zaurus touchscreen
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Liam Girdwood <liam.girdwood@wolfsonmicro.com>
In-Reply-To: <20060322135337.GA26357@flint.arm.linux.org.uk>
References: <20060322122052.GN14075@elf.ucw.cz>
	 <20060322135337.GA26357@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 15:21:17 +0000
Message-Id: <1143040877.6593.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 13:53 +0000, Russell King wrote:
> On Wed, Mar 22, 2006 at 01:20:53PM +0100, Pavel Machek wrote:
> > First, I'd like to ask: what is status of ucb1x00 audio in 2.6? I do
> > have .c file here, but do not have corresponding header files...
> 
> I never included the ucb1x00 audio patch into mainline because it
> depended on some obsolete SA11x0 OSS audio support, and I haven't had
> time to:
> 
> (a) finish my SA11x0 ALSA audio support (the stuff which is in mainline
>     is under the guise of being generic, but is actually completely ipaq
>     specific.)
> (b) convert the ucb1x00 stuff to use this generic ALSA support.
> 
> Plus there's issues surrounding where it should live (as ever).  It
> would be stretched between drivers/mfd and sound/arm and would be very
> ARM specific.

I'd like to bring people's attention to the work done on ALSA ASoC.

Some information is available at:
http://www.rpsys.net/openzaurus/patches/alsa/info.html
(I think there are more supported codecs now.)

Patches are at:
http://www.rpsys.net/openzaurus/patches/alsa/

I've cc'd Liam in on this.

The PXA Zaurus machines are going down this route for audio support and
its proving extremely functional and stable. Mainline inclusion is
likely and there has been discussion about ASoC on the ALSA mailing
lists.

Richard


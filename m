Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVFMJNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVFMJNQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVFMJNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:13:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14023 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261439AbVFMJNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:13:11 -0400
Date: Mon, 13 Jun 2005 11:07:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <emints@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050613090758.GA21087@elte.hu>
References: <Pine.LNX.4.44.0506090932300.27999-100000@dhcp153.mvista.com> <1118652783.10717.66.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118652783.10717.66.camel@ibiza.btsn.frna.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Le jeu 09/06/2005 à 18:34, Daniel Walker a écrit :
> > On Thu, 9 Jun 2005, Serge Noiraud wrote:
> > 
> > > Same problem with 48-04 and 48-05
> > > It works great with rc6 without RT patch.
> > > Here is my .config
> > > The cmdline options at boot time are :
> > > #more /proc/cmdline
> > > BOOT_IMAGE=2.6.12rc6RTV0.7.4805 ro root=306 console=ttyS0 console=tty1 \
> > > acpi=force apm=smp resume=/dev/hda5
> > 
> > 
> > 
> > Does this patch get you any further?
> > 
> Sorry for the delay , I was out of my office.
> I tested 48-19 and no more problem.
> So, is it useful to test it anymore ?
> Do you fix it another way ?

yes, the patch is in 48-19 - no need to do any further testing, thanks.

	Ingo

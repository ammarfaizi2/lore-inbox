Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVLNNet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVLNNet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVLNNet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:34:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29700 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932533AbVLNNer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:34:47 -0500
Date: Tue, 14 Dec 2004 16:01:45 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Message-ID: <20041214160145.GA2565@ucw.cz>
References: <20051203135608.GJ31395@stusta.de> <200512110312.47142.rob@landley.net> <20051212114952.GB6533@elf.ucw.cz> <200512140626.08583.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512140626.08583.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-12-05 06:26:08, Rob Landley wrote:
> On Monday 12 December 2005 05:49, Pavel Machek wrote:
> > > Or I could move initramfs extraction earlier in the boot sequence and
> > > never have to modify any _other_ drivers that want firmware in order to
> > > be able to make them work too, rather than playing whack-a-mole teaching
> > > drivers I don't care about how to hold off on wanting firmware.
> >
> > Except that whack-a-mole is a right thing to do here, and that
> > initramfs movement is unlikely to make it into mainline.
> >        Pavel
> 
> Let me guess: for licensing reasons?

Wrong. "Fix the driver" is easier to get into the kernel
than "change the boot sequence".

-- 
Thanks, Sharp!

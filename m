Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWA3X03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWA3X03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWA3X03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:26:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30389 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965039AbWA3X02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:26:28 -0500
Date: Tue, 31 Jan 2006 00:26:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <20060130232609.GA3631@elf.ucw.cz>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <43DE2FF4.nail16ZCI3FMV@burner> <20060130170904.GH19173@merlin.emma.line.org> <43DE49C5.nail2BR31RV8R@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE49C5.nail2BR31RV8R@burner>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 30-01-06 18:15:49, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > > > 2) libscg or cdrecord aborts ATA: scans as soon as one device probe
> > > >    returns EPERM, which lets devices that resmgr made accessible
> > > >    disappear from the list.
> > > 
> > > looks like your memory does not last long enough......
> > > 
> > > We did already discuss this before. If you call cdrecord with
> > > apropriatr privileges, it works.
> >
> > Well, if you're freezing the bugs, I don't see how there could be
> > progress towards a non-root cdrecord on Linux.
> 
> There is no such bug in libscg.
> 
> There is nothing that has been freezed. 
> 
> If you have the apropriate privs to send SCSI commands to any SCSI device 
> on the system, you will not come across your problem.

Why should I need privs to talk to *any* SCSI device, when I want to
talk to just *one* SCSI device?

Yes, it is a missing feature in libscg. It requires priviledge to talk
to *any* device, while is only really needs to talk to *one* device.

[Imagine ls that only worked if it had priviledges for reading
/etc/shadow. That would surely be bug.]
								Pavel

-- 
Thanks, Sharp!

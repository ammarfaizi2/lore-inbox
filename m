Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVGKS6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVGKS6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVGKS4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:56:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34740 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261452AbVGKS4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:56:16 -0400
Date: Mon, 11 Jul 2005 20:56:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][help?] Radeonfb acpi resume
Message-ID: <20050711185604.GA1997@elf.ucw.cz>
References: <42D19EE1.90809@engr.orst.edu> <42D19FEE.1040306@engr.orst.edu> <20050711151156.GA2001@elf.ucw.cz> <42D2BF5D.2030703@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D2BF5D.2030703@engr.orst.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Aww crap, thunderbird screwed up the white space...
> >>
> >>A usable version of the patch is attached, or here is a link:
> >>http://dev.gentoo.org/~marineam/files/patch-radeonfb-2.6.12
> > 
> > 
> > Wrong indentation in acpi_vgapost; I remember there was better patch
> > to fix this out there.
> Ok, I'll go through and fix any coding style problems.  I've only seen
> older versions of this same patch, but if there is a better way I'd love
> to hear it.  I'll google around a little more just in case.

It *was* version of the same patch, but it had codingstyle fixed, IIRC.

> > Anyway, are you sure machine you have can't be fixed by any methods
> > listed in Doc*/power/video.txt? I guess they are preferable to
> > acpi_vgapost...
> Actually, this is one of the metholds listed in video.txt. Take a look
> at #7 ;-).  I just tried acpi_sleep=s3_bios to see what that does, but
> just caused an instant reboot on resume.  The only other solutions that
> works is to disable the frame buffer and use X or some other app to do
> the job as listed in #5 and #6, but something in kernel like this patch
> is required to be able to use the framebuffer.

I'd say that disabling framebuffer and going #5 or #6 is still
prefered, but given nice patch, I'll probably accept it. Oh, and do
note that (7) is listed near just one notebook.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUDYUpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUDYUpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 16:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUDYUpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 16:45:20 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:53635 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263020AbUDYUpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 16:45:14 -0400
Date: Sun, 25 Apr 2004 22:45:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: ncunningham@linuxmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Message-ID: <20040425204506.GG24375@elf.ucw.cz>
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl> <20040424183505.GB2525@elf.ucw.cz> <408B7C13.1000708@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408B7C13.1000708@pointblue.com.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Second one, starting KDE, and when swap usage != 0 (just to be sure 
> >>there is no problem with any assumption), gives me loads of error 
> >>messages (see attached file).
> >>   
> >>
> >
> >Can you try CONFIG_PREEMPT=n?
> >	
> >
> Funny, now it doesn't run BUG(), but, instead I have two way behavior. 
> Either he is complaining that bash
> will not stop !! or that there is not enough pages free. Both wrong and 
> bizzareus. This really needs fixing before 2.6.6 is out (imo).

Dump stack at time when process refuses to stop, and see why it can't
be stopped. Then fix that :-).
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

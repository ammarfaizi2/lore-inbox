Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUCWXcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbUCWXcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:32:52 -0500
Received: from gprs214-90.eurotel.cz ([160.218.214.90]:21890 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262911AbUCWXcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:32:51 -0500
Date: Wed, 24 Mar 2004 00:32:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Jonathan Sambrook <swsusp@hmmn.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040323233228.GK364@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403231743.01642.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also, in your model, where do messages printk()-ed from drivers during
> > suspend/resume end up? Corrupting screen? Lost from sight and only
> > accessible from dmesg? I believe driver messages *are* important, and
> > do not see how they could coexist with eye-candy.
> > 
> Well, unless these are error messages that prevent machine from suspending/
> resuming they are really just another form of eye-candy, nothing more,
> nothing less.

Well, I'd hate

Nov 10 00:37:51 amd kernel: Buffer I/O error on device sr0, logical block 842340
Nov 10 00:37:53 amd kernel: end_request: I/O error, dev sr0, sector 6738472

to be obscured by progress bar.

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268495AbTGLTee (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbTGLTee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:34:34 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:59302 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S268495AbTGLTec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:34:32 -0400
Date: Sun, 13 Jul 2003 07:38:21 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
In-reply-to: <20030712153719.GA206@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058038701.2482.25.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux>
 <20030712153719.GA206@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2003-07-13 at 03:37, Pavel Machek wrote:
> > > > - nice display
> > > > - user can abort at any time during suspend (oh, I forgot, I wanted
> > > > to...) by just pressing Escape
> > > 
> > > That seems like missfeature. We don't want joe random user that is at
> > > the console to prevent suspend by just pressing Escape. Maybe magic
> > > key to do that would be acceptable...
> > 
> > Magic key? Do you mean a password? I suppose that could be a
> 
> Documentation/sysrq.txt. Magic sysrq driver will answer some
> interesting questions like "how to press esc on the serial line", etc,
> and it is also /proc configurable.

Oh so you just be having (eg) to press SysRq-Escape? Isn't that just
security by obscurity? I'd rather go for the password idea. Sounds like
there should be a few options for what is required to abort with one
chosen at make config time.

1.0 tomorrow unless there's anything big in the meantime.

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.


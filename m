Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268619AbTGLWTR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268626AbTGLWTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:19:17 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:22795 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268619AbTGLWTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:19:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Date: Sat, 12 Jul 2003 17:34:29 -0500
User-Agent: KMail/1.5.1
Cc: Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz>
In-Reply-To: <20030712140057.GC284@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121734.29941.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 July 2003 09:00 am, Pavel Machek wrote:
> > - user can abort at any time during suspend (oh, I forgot, I wanted
> > to...) by just pressing Escape
>
> That seems like missfeature. We don't want joe random user that is at
> the console to prevent suspend by just pressing Escape. Maybe magic
> key to do that would be acceptable...

In case when suspending (and interrupting suspend) matters most - 
laptops - Joe random user is the only user present. I myself would
rather have an option to press ESC than remember what SysRq really 
maps to as by the time I would figure that out the laptop would already
be suspended.

IMHO, an option to use ESC, probably compile time option, is a good 
thing.

Dmitry


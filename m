Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbSKQNNc>; Sun, 17 Nov 2002 08:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbSKQNNc>; Sun, 17 Nov 2002 08:13:32 -0500
Received: from web20506.mail.yahoo.com ([216.136.226.141]:52047 "HELO
	web20506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267498AbSKQNNb>; Sun, 17 Nov 2002 08:13:31 -0500
Message-ID: <20021117132030.51709.qmail@web20506.mail.yahoo.com>
Date: Sun, 17 Nov 2002 14:20:30 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [PATCH] kmsgdump for 2.5.47
To: Justin A <ja6447@albany.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200211161756.51449.ja6447@albany.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is kmsgdump for 2.5.47, most of it was just
> putting rejects back in that  had been too far
> offset for patch.

thanks, that's nice to see that this old 2.2 patch
still works without too much changes on 2.4 and 2.5.
I think it's because it touches only really stable
parts of the kernel :-)

If you're interested, I've updated the web site and
put your patch on it under 0.4.3. BTW, a long time
ago (about april), I updated it to 0.4.4, but didn't
put it on the web site. The only change is that now
by default, it automaticall scrolls to the end of the
messages when dumping on the screen, so that with a
few presses on the "up" key, you can see the most
interesting messages.

The patch is really trivial, and should apply above
yours without difficulty. I've put it in the 0.4.4
directory ( http://w.ods.org/tools/kmsgdump/0.4.4/ ).

> The only thing I had to change was that proccess.c
> didn't know about kb_wait and no_idt from reboot.c,
> and I couldn't figure out what to add to reboot.h
> for them so I just did:

seems correct to me since it works this way in 2.4.

> I guess if it worked for you in 2.4, it should also
> work in 2.5...All I know is that it worked for 
> me(tm) and should be useful to someone else :)

thanks, I'll try as soon as I recompile a 2.5, but not
immediately though.

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com

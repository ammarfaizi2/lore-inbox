Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267784AbTAXRFJ>; Fri, 24 Jan 2003 12:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267786AbTAXRFJ>; Fri, 24 Jan 2003 12:05:09 -0500
Received: from web80310.mail.yahoo.com ([66.218.79.26]:51736 "HELO
	web80310.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267784AbTAXRFI>; Fri, 24 Jan 2003 12:05:08 -0500
Message-ID: <20030124171415.34636.qmail@web80310.mail.yahoo.com>
Date: Fri, 24 Jan 2003 09:14:15 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030124154935.GB20371@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Pavel Machek <pavel@ucw.cz> wrote:

> How is plex86-aware-linux running under plex86 different from user
> mode linux?

With plex86, the goal is to run the stock x86 port.  Plex86 is also
x86-specific.

> Do you think you can make it faster?

To get any level of security with UML, you need to use "jailed mode"
in which performance takes a big beating.  To fix this, you need
patches to Linux as a host, to make it offer a better environment
for running UML guests.  From a commercial perspective, then you have
a patched Linux host + totally different port of a Linux guest.
>From a fun perspective, I think UML is fantastic achievement.

What I'm aiming for is a stock Linux host and a stock Linux guest,
the small mods to macroize PUSHF/POPF being a minor concession
to accomodate a broken PVI support in x86.


-Kevin

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com

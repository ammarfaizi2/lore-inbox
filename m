Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSJIOu1>; Wed, 9 Oct 2002 10:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261787AbSJIOu1>; Wed, 9 Oct 2002 10:50:27 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:49669 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261784AbSJIOu0>; Wed, 9 Oct 2002 10:50:26 -0400
Date: Wed, 9 Oct 2002 16:55:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Brendan J Simon <brendan.simon@bigpond.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
In-Reply-To: <3DA43C3A.2060608@bigpond.com>
Message-ID: <Pine.LNX.4.44.0210091646540.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Oct 2002, Brendan J Simon wrote:

> As you can see there are soooooo many guis to choose/use and everyone
> has there favourite.  I suggest that the real work be done outside of
> the GUI program.  ie. seperate GUI and application guts as much as
> possible.  I would use python as the main language but C or even C++
> could be used instead as a lot of people hate interpreters, or hate
> python (prefer perl, php or something else).
>
> I'm pretty sure there is no one solution and it comes down to the
> politics and preferences of the final decision makers up the heirarchy.

Because of this I'm planning to make the config backend available as
shared library, so it can be loaded by external programs. My QT app then
would be basically just the reference implementation.
I also want to add a SWIG interface file, so you can even access the
config database with your preferred script language.

bye, Roman


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319089AbSH2E1D>; Thu, 29 Aug 2002 00:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319091AbSH2E1C>; Thu, 29 Aug 2002 00:27:02 -0400
Received: from 24-148-63-229.na.21stcentury.net ([24.148.63.229]:40499 "HELO
	wotke.danapple.com") by vger.kernel.org with SMTP
	id <S319089AbSH2E1C>; Thu, 29 Aug 2002 00:27:02 -0400
To: linux-kernel@vger.kernel.org
To: "Daniel I. Applebaum" <kernel@danapple.com>
Subject: Re: Boot & VM problems 2.4.14-2.5.31 
In-Reply-To: Your message of "Tue, 27 Aug 2002 17:13:50 CDT."
             <20020827221355.18FFE111F0@wotke.danapple.com> 
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Wed, 28 Aug 2002 23:31:13 -0500
Message-Id: <20020829043118.20FD9111F0@wotke.danapple.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI: My booting problems are now solved.  Thanks to help from Robert
Schwebel, I replaced the setup.S in my 2.4.19 with the setup.S from my
2.4.13 tree and the system booted.  So, there was some change in
setup.S that is incompatible with my system.  I'll post more info if
and when I find it.

I haven't tested paging, but audio ripping still fails.  But at least
I have the hope to work on recent kernel source.

Dan.
++++++++++++++++++++
What I wrote before:
> OK, let me start over.  I have three different problems with running
> Linux on my system.  The first is that I can't rip audio CDs.
... 
> But, when updating to 2.4.14, I get an Oops, as soon as the system
> starts to page.
...
> When using a kernel 2.4.15-pre3 or later, the system won't even
> boot.

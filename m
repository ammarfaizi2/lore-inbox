Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSFFSvA>; Thu, 6 Jun 2002 14:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSFFSta>; Thu, 6 Jun 2002 14:49:30 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:20363 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317096AbSFFSsf>;
	Thu, 6 Jun 2002 14:48:35 -0400
Date: Thu, 6 Jun 2002 20:48:35 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206061848.UAA19403@harpo.it.uu.se>
To: stuartm@connecttech.com
Subject: Re: [BUG] dd, floppy, 2.5.18
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 14:19:22 -0400, Stuart MacDonald wrote:
># uname -a
>Linux moll 2.5.18 #1 SMP Wed May 29 15:18:20 EDT 2002 i686 unknown

[various floppy problems]

The floppy driver got broken in 2.5.13. Please try the following patch:
http://www.csd.uu.se/~mikpe/linux/patches/2.5/patch-fix-floppy-2.5.20
It works for me and at least one other person.

/Mikael

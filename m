Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbRBJFAW>; Sat, 10 Feb 2001 00:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRBJFAM>; Sat, 10 Feb 2001 00:00:12 -0500
Received: from kiln.isn.net ([198.167.161.1]:15418 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S129716AbRBJE74>;
	Fri, 9 Feb 2001 23:59:56 -0500
Message-ID: <3A84CA90.B2DC6AC0@isn.net>
Date: Sat, 10 Feb 2001 00:58:56 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cranford <ac9410@bellsouth.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: compiling 2.4.1 with binutils-2.10.1.0.7
In-Reply-To: <3A844C76.59CBEE74@isn.net> <3A845610.1FB1317C@bellsouth.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> 
 
> I got tired of the warnings myself, so I applied the attached
> patch.  I've been testing newer binutils since last November with it.
> Later,
> Albert
Thanks Albert, I'll test it an let you know if I have any problems.
Have you sent it to Linus?
Have you also tried to compile the kernel with gcc-2.97 (20010205)?
Oops, the problem was that I did not read the release notes for the
latest
binutils
-oformat needs to get changed to --oformat in the Makefile for
arch/i386/boot
Garst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283057AbRLOSAH>; Sat, 15 Dec 2001 13:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283114AbRLOR77>; Sat, 15 Dec 2001 12:59:59 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:23434 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S283057AbRLOR7w>; Sat, 15 Dec 2001 12:59:52 -0500
Date: Sat, 15 Dec 2001 18:59:38 +0100
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.4.16 kernel with sound support
Message-ID: <20011215175938.GB11441@links2linux.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011215184755.1633ef56.tsauter@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011215184755.1633ef56.tsauter@gmx.net>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16 i586
X-Editor: VIM 6.0
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thorsten Sauter schrieb am 15.12.01 um 18:47 Uhr:
> 
> Hallo Kernel-List,
> 
> I have big problems with sound support in 2.4.16. I just download the tarball and untar it.
> If I make now a simple "make dep && make clean && make bzImage" everthink works fine.
> 
> But after including any sound stuff, the linker always print an error and exit. :(
> After I remove the previous select sound staff, the kernel compile cleanly.
> 
> The base distri is the current debian sid (apt update today). Here are some environment infos:
> Distri: Debian Sid (i386)
> GCC Version: 2.95.4
> LD Version: 2.11.92.0.12.3
> 
> if you need more infos please let me know.
> 
> 
[error output]


Did you try a "make mrproper" before doing the make
dep/clean/bzImage ?

(backup your .config before makeing mrproper...)

-Marc

-- 
|             ...and don't forget: Linux rulez!                    |
|                                                                  |
| http://www.links2linux.de <-- Von Linux-Usern fuer Linux-User    |


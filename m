Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313187AbSECOKQ>; Fri, 3 May 2002 10:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313199AbSECOKP>; Fri, 3 May 2002 10:10:15 -0400
Received: from mcewen.wcnet.org ([63.174.200.22]:45496 "EHLO mcewen.wcnet.org")
	by vger.kernel.org with ESMTP id <S313187AbSECOKN>;
	Fri, 3 May 2002 10:10:13 -0400
Date: Fri, 3 May 2002 10:11:18 -0400 (EDT)
From: <skmail@mcewen.wcnet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel strangeness
In-Reply-To: <E173NEc-0004lB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0205031009100.24533-100000@mcewen.wcnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.  I will try replacing the glibc.  If I understand right (I'm 
not a programmer) I will need to recompile the kernel, and possibly some 
other programs, against the i386 glibc.  Correct?



On Thu, 2 May 2002, Alan Cox wrote:

> > ethernets, 64 meg memory, and an AMD Elan SC520.  I loaded the flash disk 
> > on a full install of RH 7.2.  Custom compiled the kernel for no modules, 
> > for an i386 architecture.  It works fine on the desktop system I used to 
> > load it, but when I put it on the net4501,  Lilo loads, starts loading the 
> > kernel, then it hangs.  The last message on the screen is Freeing unused 
> > kernel memory.  I also downloaded the latest 2.4.19-pre7, compiled it for 
> > the Elan processor, with no success.  Same thing happens.  
> 
> Thats the classic case when you have a i686 glibc rather than the i386/486
> glibc that is needed by the Elan board. Swap for the i386 glibc
> 


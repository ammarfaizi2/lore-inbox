Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSEBUZj>; Thu, 2 May 2002 16:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315407AbSEBUZi>; Thu, 2 May 2002 16:25:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13328 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315406AbSEBUZh>; Thu, 2 May 2002 16:25:37 -0400
Subject: Re: kernel strangeness
To: skmail@mcewen.wcnet.org
Date: Thu, 2 May 2002 21:31:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205021516240.4418-100000@mcewen.wcnet.org> from "skmail@mcewen.wcnet.org" at May 02, 2002 03:24:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173NEc-0004lB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ethernets, 64 meg memory, and an AMD Elan SC520.  I loaded the flash disk 
> on a full install of RH 7.2.  Custom compiled the kernel for no modules, 
> for an i386 architecture.  It works fine on the desktop system I used to 
> load it, but when I put it on the net4501,  Lilo loads, starts loading the 
> kernel, then it hangs.  The last message on the screen is Freeing unused 
> kernel memory.  I also downloaded the latest 2.4.19-pre7, compiled it for 
> the Elan processor, with no success.  Same thing happens.  

Thats the classic case when you have a i686 glibc rather than the i386/486
glibc that is needed by the Elan board. Swap for the i386 glibc

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271782AbRICTEA>; Mon, 3 Sep 2001 15:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271787AbRICTDu>; Mon, 3 Sep 2001 15:03:50 -0400
Received: from [209.38.98.99] ([209.38.98.99]:34741 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S271786AbRICTDm>;
	Mon, 3 Sep 2001 15:03:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred <fred@arkansaswebs.com>
To: Subba Rao <subba9@home.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems installing FreeS/WAN 1.9.1 on kernel 2.4.9
Date: Mon, 3 Sep 2001 14:03:59 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010903133025.B31122@home.com>
In-Reply-To: <20010903133025.B31122@home.com>
MIME-Version: 1.0
Message-Id: <01090314035904.21988@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looks similiar to problems I had a while back because I didn't 'make 
mrproper'.
try removing FreeS/WAN 1.9.1 and kernel sources, then untar the kernel, do: 

make mrproper 
make xconfig 
make dep clean <bzImage | install> modules modules_install

if this works, then do

make mrproper
add the FreeS/WAN 1.9.1 code
make xconfig 
make dep clean <bzImage | install> modules modules_install

hope this helps

Fred

 _________________________________________________ 
On Monday 03 September 2001 12:30 pm, Subba Rao wrote:
> Could anyone here get FreeS/WAN 1.9.1 to compile on kernel 2.4.9?
> My kernel compilation is ending with tons of warnings and errors. Before
> installing the FreeS/WAN code, I have customized kernel 2.4.9 and installed
> it without any problems.
>
> Here is what I did so far:
>
> 	1. tar xzvf freeswan-1.91.tar.gz (in /usr/src)
> 	2. cd freeswan-1.91
> 	3. make insert
> 	4. make programs
> 	5. make install
> 	6. cd ../linux
> 	7. make depend; make bzImage
>
> My distribution is Slackware 8 runnning kernel 2.4.9
>
> I have listed the errors, once build goes into ipsec directory.
>
> If anyone got the ipsec compiled into kernel 2.4.9, please let me know how
> you did it.
>
> TIA.

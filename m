Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSGYNVo>; Thu, 25 Jul 2002 09:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSGYNVn>; Thu, 25 Jul 2002 09:21:43 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:2308 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313563AbSGYNVj>;
	Thu, 25 Jul 2002 09:21:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Anton Altaparmakov <aia21@cantab.net>
Date: Thu, 25 Jul 2002 15:24:10 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: RE: 2.5.28 and partitions
CC: Linus Torvalds <torvalds@transmeta.com>, Matt_Domsch@Dell.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1D94527606@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 02 at 14:03, Anton Altaparmakov wrote:
> At 12:44 25/07/02, Alexander Viro wrote:
> >Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> >device should seek professional help of the kind they don't give on l-k...
> 
> Why? What is wrong with large devices/file systems? Why do we have to break 
> up everything into multiple devices? Just because the kernel is "too lazy" 
> to implement support for large devices? Nobody cares if 64bit code is 
> 10-20% slower than 32bit code on a storage server. The storage devices are 

But I care whether gcc barfs on code or not, and whether generated code
is correct or not.

I do very trivial 64bit computations in TV-Out portion of matroxfb,
but I spent two days shifting code up/down, adding temporary variables
and splitting expressions to simple ones to make code compilable at all
with gcc-2.95.4 compiling module for PIII kernel (Debian bug #151196). 
So I personally cannot recommend doing any 64bit math without setting
gcc-3.0 as minimal version for ia32 architecture.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

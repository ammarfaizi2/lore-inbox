Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275067AbRJUBUk>; Sat, 20 Oct 2001 21:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275097AbRJUBUa>; Sat, 20 Oct 2001 21:20:30 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:48378 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S275067AbRJUBUR>;
	Sat, 20 Oct 2001 21:20:17 -0400
Date: Sun, 21 Oct 2001 03:20:37 +0200
From: David Weinehall <tao@acc.umu.se>
To: Keith Owens <kaos@ocs.com.au>
Cc: Stuart Luscombe <stuart@ubersecksie.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compilation of 2.4.0 fails when processing /i386/boot
Message-ID: <20011021032037.Q25701@khan.acc.umu.se>
In-Reply-To: <20011020231131.A4560@ubersecksie.co.uk> <4498.1003626939@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <4498.1003626939@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Oct 21, 2001 at 11:15:39AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 11:15:39AM +1000, Keith Owens wrote:
> On Sat, 20 Oct 2001 23:11:31 +0000, 
> Stuart Luscombe <stuart@ubersecksie.co.uk> wrote:
> >I am compiling kernel 2.4.0, and I am getting the following error
> >during the 'make install' part of the build:
> >ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
> >make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
> >ld: cannot open binary: No such file or directory
> 
> New binutils on an old kernel.  Change -oformat to --oformat.

Or even better, change v2.4.0 to v2.4.13pre5 or v2.4.12ac3.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

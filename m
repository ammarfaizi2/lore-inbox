Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSFKPPS>; Tue, 11 Jun 2002 11:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSFKPPR>; Tue, 11 Jun 2002 11:15:17 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:40458 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317018AbSFKPPR>; Tue, 11 Jun 2002 11:15:17 -0400
Message-ID: <3D061484.3030903@loewe-komp.de>
Date: Tue, 11 Jun 2002 17:17:24 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels hang before uncompressing
In-Reply-To: <200206111436.g5BEa4Z17577@drtalus.aoe.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cengiz Akinli wrote:
> Hello all,
> 
>    We have a Tri-M PC-104 system with a Cyrix ZF486 processor that (in
> addition to being painfully slow building kernels) refuses to boot any
> 2.4.x kernels.  It has a M-Systems Disk-On-Chip 2000 (which ironically,
> I got to work just fine with the 2.2.x kernel that I had to patch, but
> NOT with the 2.4 kernel that comes with a driver), but I don't think that's
> the problem, because the 2.4.x kernel is not even uncompressing, to say
> nothing of booting and trying to mount the root fs.
> 
>   It DOES appear to finish loading, because it outputs a linefeed after
> the line of dots in 'Loading linux....'
> 
[..]
>   The lilo used to install the boot sector on this Disk On Chip is
> a custom-patched one provided by the vendor.  It works fine on 2.2.x
> kernels.  Should I suspect it?
> 

Perhaps the patched lilo can't cope with bzImage - only zImage?
only a cheap guess

Did you try to compile the kernel as i386?


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132699AbQLaBrF>; Sat, 30 Dec 2000 20:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbQLaBqz>; Sat, 30 Dec 2000 20:46:55 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:60876 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S132699AbQLaBqg>; Sat, 30 Dec 2000 20:46:36 -0500
Date: Sun, 31 Dec 2000 01:16:04 +0000 (GMT)
From: davej@suse.de
To: Tony Spinillo <tspin@epix.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TEST13-PRE7 - Nvidia Kernel Module Compile Problem
In-Reply-To: <20001231140527.A21365@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.21.0012310114510.13512-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 07:54:21PM +0000, Tony Spinillo wrote:
>   The nvidia kernel module (from www.nvidia.com) has compiled and loaded
>   correctly with all test13-pre series up to pre6. I just tried to
>   compile and load under pre7.
>   I got the following:
>   nv.c:860:unknown field `unmap' specified in initializer
>   nv.c:860:warning: initialization from incompatible pointer type
>   make:*** [nv.o] Error 1

Delete the unmap: line somewhere near line 868 of nv.c
Seems to be working fine here.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

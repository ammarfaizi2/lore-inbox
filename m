Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274834AbRIUVCj>; Fri, 21 Sep 2001 17:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274835AbRIUVC3>; Fri, 21 Sep 2001 17:02:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:21257 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274834AbRIUVCL>;
	Fri, 21 Sep 2001 17:02:11 -0400
Date: Fri, 21 Sep 2001 18:00:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: major VM suckage with 2.4.10pre12 and 2.4.10pre13 and highmem,
 we  will help test
In-Reply-To: <F341E03C8ED6D311805E00902761278C04728F82@xfc04.fc.hp.com>
Message-ID: <Pine.LNX.4.33L.0109211759060.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, HABBINGA,ERIK (HP-Loveland,ex1) wrote:

> Kernel 2.4.10pre13 did not help our NFS SPEC testing on a machine with
> 4GB RAM.  Refer to my previous message about those results:
> http://lists.insecure.org/linux-kernel/2001/Sep/3036.html
>
> In a nutshell, kswapd starts grabbing 99% of the CPU for long
> stretches in time, which causes us to drop NFS RPC connections, which
> causes performance to suck.

I'm curious, how do recent -ac kernels perform here ?

If you have the time, could you test 2.4.9-ac13 plain
and 2.4.9-ac13 with my page aging and launder patches
from http://www.surriel.com/patches/ ?  ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


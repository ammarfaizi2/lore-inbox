Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbRA3SZF>; Tue, 30 Jan 2001 13:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131891AbRA3SYp>; Tue, 30 Jan 2001 13:24:45 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:64497 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131841AbRA3SYn>; Tue, 30 Jan 2001 13:24:43 -0500
Date: Tue, 30 Jan 2001 16:23:58 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jon Anderson <andersoj@mediaone.net>
cc: Ronald Lembcke <es186@fen-net.de>, linux-kernel@vger.kernel.org
Subject: Re: no boot with 2.4.x
In-Reply-To: <20010130131511.D22358@mediaone.net>
Message-ID: <Pine.LNX.4.21.0101301622460.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Jon Anderson wrote:

> After compiling 2.4 and 2.4ac11 I got failed boots as well, getting 
> either 
> 
>   LI
> 
> or 
> 
>   LIL
> 
> And then nothing.  This is a K6-2 450 machine, all previous
> (2.4.0-test*)  kernels worked fine.

You messed up in the LILO configuration, this isn't a kernel
problem because lilo halts before the kernel's first disk
block is being read in from disk...

If you start from a boot disk and re-run lilo, things might
just work again.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

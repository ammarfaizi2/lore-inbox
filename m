Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUCAU6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUCAU6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:58:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:7126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261433AbUCAU57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:57:59 -0500
Date: Mon, 1 Mar 2004 12:57:52 -0800
From: cliff white <cliffw@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernbench v0.30
Message-Id: <20040301125752.5ef9041d.cliffw@osdl.org>
In-Reply-To: <200403011223.31059.kernel@kolivas.org>
References: <200403011223.31059.kernel@kolivas.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004 12:23:25 +1100
Con Kolivas <kernel@kolivas.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Kernbench v0.30
> 
> http://ck.kolivas.org/kernbench/
> 
> Changelog:
> v0.30 Added fast run option which bypasses caching, warmup and tree 
> 	preparation and drops number of runs to 3. Modified half loads to 
> 	detect -j2 and change to -j3. Added syncs. Improved warnings and 
> 	messages. 
> 

STP version updated also, thanks
cliffw
> 
> What is this?
> 
> This is a cpu throughput benchmark originally devised and used by Martin J.
> Bligh. It is designed to compare kernels on the same machine, or to compare
> hardware. To compare hardware you need to be running the same architecture
> machines (eg i386) and run kernbench on the same kernel source tree.
> 
> It runs a kernel at various numbers of concurrent jobs: 1/2 number of cpus, 
> optimal (default is 4xnumber of cpus) and maximal job count. Optionally it can
> also run single threaded. It then prints out a number of useful statistics
> for the average of each group of runs.
> 
> You need at least 2Gb of ram for this to be a true throughput benchmark or 
> else you will get swapstorms.
> 
> Ideally it should be run in single user mode on a non-journalled filesystem.
> To compare results it should always be run in the same kernel tree.
> 
> 
> How do I use it?
> 
> You need a kernel tree (any will do) and the applications 'time' and 'awk' 
> installed. 'time' is different to the builtin time used by BASH and has more
> features desired for this benchmark.
>  
> Simply cd into the kernel tree directory and type
> 
> /path/to/kernbench
> 
> 
> Options
> 
> kernbench [-n runs] [-o jobs] [-s] [-H] [-O] [-M] [-h] [-v]
> n : number of times to perform benchmark (default 5)
> o : number of jobs for optimal run (default 4 * cpu)
> s : perform single threaded runs (default don't)
> H : don't perform half load runs (default do)
> O : don't perform optimal load runs (default do)
> M : don't perform maximal load runs (default do)
> f : fast run
> h : print this help
> v : print version number
> 
> 
> Con
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQFAQpCPZUg7+tp6mRURAgvfAJ4lyrnuOns0NSvCY9usWnnhiv2ZpQCbBI04
> zvd+1jYdtTwFatWBUEuoERI=
> =Eq2l
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb

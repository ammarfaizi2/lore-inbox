Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136798AbRASCNj>; Thu, 18 Jan 2001 21:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136795AbRASCNa>; Thu, 18 Jan 2001 21:13:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18447 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136779AbRASCNY>;
	Thu, 18 Jan 2001 21:13:24 -0500
Date: Fri, 19 Jan 2001 03:13:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010119031303.D18452@suse.de>
In-Reply-To: <Pine.LNX.4.30.0101182208420.1729-100000@fs131-224.f-secure.com> <Pine.LNX.4.30.0101190416570.1729-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101190416570.1729-100000@fs131-224.f-secure.com>; from szaka@f-secure.com on Fri, Jan 19, 2001 at 04:23:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19 2001, Szabolcs Szakacsits wrote:
> 
> Redone with big enough swap by requests.
> 
> 2.4.0,132MB swap
> 548.81user 128.97system    11:22  99%CPU (442433major+705419minor)
> 561.12user 171.06system    12:29  97%CPU (446949major+712525minor)
> 625.68user 2833.29system 1:12:38  79%CPU (638957major+1463974minor)
> ===========
> 2.4.1pre8,132MB swap
> 548.71user 117.93system    11:09  99%CPU (442434major+705420minor)
> 558.93user 166.82system    12:20  98%CPU (446941major+712662minor)
> 621.37user 2592.54system 1:07:33  79%CPU (592679major+1311442minor)

Better, could you try with the number changes that Andrea suggested
too? Thanks.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

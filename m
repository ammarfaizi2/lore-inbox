Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263222AbREWTKG>; Wed, 23 May 2001 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263221AbREWTJ4>; Wed, 23 May 2001 15:09:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:51066 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263223AbREWTJu>; Wed, 23 May 2001 15:09:50 -0400
Date: Wed, 23 May 2001 21:09:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "G. Hugh Song" <ghsong@kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap strangeness using 2.4.5pre2aa1
Message-ID: <20010523210923.A730@athlon.random>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr>; from ghsong@kjist.ac.kr on Thu, May 24, 2001 at 03:16:48AM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 03:16:48AM +0900, G. Hugh Song wrote:
> The following is the output from "free"
> =========================================================================
>              total       used       free     shared    buffers    
> cached
> Mem:       1023128    1015640       7488          0        544    
> 948976
> -/+ buffers/cache:      66120     957008
> Swap:      1021936    1021936          0
> ==========================================================================

I get the same with egcs. To me it sounds broken VM (I shouldn't have
changed anything that can confuse the VM so this should be reproducible
with 2.4.5pre5 vanilla and infact you also said you reproduced
previously in 2.4.4).

Is it possible you booted with 'mem=something'? It seems to me that when
I boot with 'mem=something' the VM bad beahaviour become more visible.

> I think I should back down to Kernel 2.2.20pre2aa1.

definitely a good idea until somebody fixes the VM in mainline.

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRELP4R>; Sat, 12 May 2001 11:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbRELP4H>; Sat, 12 May 2001 11:56:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35162 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261275AbRELP4A>; Sat, 12 May 2001 11:56:00 -0400
Date: Sat, 12 May 2001 17:55:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: root <root@verdi.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: correctable ECC error
Message-ID: <20010512175534.B17311@athlon.random>
In-Reply-To: <200105121544.f4CFijp26537@verdi.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105121544.f4CFijp26537@verdi.kjist.ac.kr>; from root@verdi.kjist.ac.kr on Sun, May 13, 2001 at 12:44:45AM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 12:44:45AM +0900, root wrote:
> 
> On UP2000 SMP with two 21264 CPU's running 2.4.5pre1aa1 and 2.2.19aa1,
> I am getting the following message:
> 
> ===================================================
> 
> May 12 07:02:09 norma kernel: TSUNAMI machine check: vector=0x630 pc=0x20001170070 code=0x100000086
> May 12 07:02:09 norma kernel: machine check type: correctable ECC error (retryable)
> May 12 07:02:16 norma init: PANIC: segmentation violation! sleeping for 30 seconds.
> May 12 07:02:46 norma init: PANIC: segmentation violation! sleeping for 30 seconds.

almost certainly it's due buggy ram, ECC checks trapped it.

> Is one of my memory modules failiing?  BTW, it did not sleep when 

yes.

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271581AbRHUMOY>; Tue, 21 Aug 2001 08:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271643AbRHUMOP>; Tue, 21 Aug 2001 08:14:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56078 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S271581AbRHUMOL>;
	Tue, 21 Aug 2001 08:14:11 -0400
Date: Tue, 21 Aug 2001 14:12:53 +0200
From: Jens Axboe <axboe@suse.de>
To: "Ram'on Garc'ia Fern'andez" <ramon@jl1.quim.ucm.es>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Kernel Crash 2.4.8
Message-ID: <20010821141253.G672@suse.de>
In-Reply-To: <20010821140045.A1710@jl1.quim.ucm.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010821140045.A1710@jl1.quim.ucm.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21 2001, Ram'on Garc'ia Fern'andez wrote:
> Hello
> 
> This crash was produced when mounting the Zip drive.
> 
> (This causes modprobe to load the ide-scsi module)
> 
> Kernel 2.4.8 SMP. 2 Pentium III processors 800 MHz
> 
> I had to write by hand all the kernel messages. Please
> forgive mistakes.
> 
> Ramon
> 
> EIP: C0186B6A (account_io_start + 0x26)
> *PDE = 0
> Flags = 10046
> EAX = 0
> EBX = 393946
> ECX = 2
> EDX = 0
> ESI = 2
> EDI = 0
> EBP = C7F33018
> ESP = C78E3CC0
> DS = ES = SS = 18
> process modprobe
> Stack: C75C2C60 C0186C02 00393946 C75C2C60 0 2 2 C40F0DA0
> 0  39346 0 C0187466 C75C2C60 0 2 C40F0DA0
> Call trace:
> C0186C02 req_new_io+0x36

What else did you patch into this kernel? The above looks like it came
from the sard patches, not part of the stock tree.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269356AbRH0Hiv>; Mon, 27 Aug 2001 03:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271658AbRH0Him>; Mon, 27 Aug 2001 03:38:42 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:17437 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269356AbRH0Hic>; Mon, 27 Aug 2001 03:38:32 -0400
Date: Mon, 27 Aug 2001 09:38:35 +0200
From: Cliff Albert <cliff@oisec.net>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, nigel@nrg.org
Subject: Re: Updated Linux kernel preemption patches
Message-ID: <20010827093835.A15153@oisec.net>
In-Reply-To: <998877465.801.19.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998877465.801.19.camel@phantasy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 09:57:43PM -0400, Robert Love wrote:

> Available at:
> 
> http://tech9.net/rml/linux/patch-rml-2.4.9-preempt-kernel-1
> http://tech9.net/rml/linux/patch-rml-2.4.8-ac12-preempt-kernel-1
> 
> for kernel 2.4.9 and 2.4.8-ac12, respectively.
> 
> This is a straight update of Nigel Gamble's Linux kernel preemption
> patch from http://kpreempt.sourceforge.net, updated for the above
> kernels.  Thus, this is Nigel's code -- I merely updated it.
> 
> I am eager to see work done on the patch and to see what its future may
> be.  If you are in any way interested in application latency or
> real-time support, I suggest you check this out.  If you are just
> curious, its an interesting patch none-the-less.

Kernel won't compile when this patch is applied to 2.4.8-ac12

kernel/kernel.o: In function `mmput':
kernel/kernel.o(.text+0x1853): undefined reference to `atomic_dec_and_lock'
kernel/kernel.o: In function `free_uid':
kernel/kernel.o(.text+0xaea0): undefined reference to `atomic_dec_and_lock'
fs/fs.o: In function `kill_super':
fs/fs.o(.text+0x7002): undefined reference to `atomic_dec_and_lock'
fs/fs.o: In function `dput':
fs/fs.o(.text+0x13365): undefined reference to `atomic_dec_and_lock'
fs/fs.o: In function `iput':
fs/fs.o(.text+0x15ed2): undefined reference to `atomic_dec_and_lock'


-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282408AbRKXJj1>; Sat, 24 Nov 2001 04:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282409AbRKXJjR>; Sat, 24 Nov 2001 04:39:17 -0500
Received: from [213.228.128.56] ([213.228.128.56]:11003 "HELO
	front1.netvisao.pt") by vger.kernel.org with SMTP
	id <S282408AbRKXJjF>; Sat, 24 Nov 2001 04:39:05 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15aa1
In-Reply-To: <20011124085028.C1419@athlon.random>
From: pocm@rnl.ist.utl.pt (Paulo J. Matos aka PDestroy)
Date: 24 Nov 2001 09:45:39 +0000
In-Reply-To: <20011124085028.C1419@athlon.random>
Message-ID: <m36680tscc.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Will this fix the potential possibility of 2.4.15 screwing my
system? (inode problem as people have been mentioning it, etc?)

Best regards,

Paulo

Andrea Arcangeli <andrea@suse.de> writes:

> Note: the "00_read_super-stale-inode-1" fix is under discussion with Al,
> but overall it should be just ok for public consumation (even if that
> are may change if we find any better alternative, at the moment I think
> it is better (cleaner, simpler and faster) alternative than the iput
> changes in function of the MS_ACTIVE info).
> 
> URL:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15aa1.bz2
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15aa1/
> 
> Only in 2.4.15aa1: 00_iput-unmount-corruption-fix-1
> 
> 	Fix iput umount corruption.
> 
> Only in 2.4.15aa1: 00_read_super-stale-inode-1
> 
> 	If read_super fails avoid lefting stale inodes queued into
> 	the superblock.
> 
> Only in 2.4.15pre9aa1: 10_vm-16
> Only in 2.4.15aa1: 10_vm-17
> 
> 	Dropped a leftover touch_buffer in bread (there's just one in getblk in
> 	-aa, and we need it in getblk [not only for reiserfs]).
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Paulo J. Matos aka PDestroy : pocm(_at_)rnl.ist.utl.pt
Instituto Superior Tecnico - Lisbon    
Software & Computer Engineering - A.I.
 - > http://www.rnl.ist.utl.pt/~pocm 
 ---	
	Yes, God had a deadline...
		So, He wrote it all in Lisp!


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBFMmn>; Tue, 6 Feb 2001 07:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129058AbRBFMmd>; Tue, 6 Feb 2001 07:42:33 -0500
Received: from [211.100.91.213] ([211.100.91.213]:26862 "EHLO
	marvin.zhlinux.com") by vger.kernel.org with ESMTP
	id <S129057AbRBFMmT>; Tue, 6 Feb 2001 07:42:19 -0500
Date: Tue, 6 Feb 2001 20:41:43 +0800
From: Wenzhuo Zhang <wenzhuo@zhmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: solics@icafe.ro, reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] mongo.sh 2.2.18: do_try_to_free_pages failed
Message-ID: <20010206204143.A5260@zhmail.com>
In-Reply-To: <Pine.LNX.4.21.0102061140530.16736-100000@mail.icafe.ro> <E14Q6CX-0005Ok-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Q6CX-0005Ok-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 06, 2001 at 11:22:22AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 11:22:22AM +0000, Alan Cox wrote:
> > This is a bad RAM problem, or insufficient RAM (slightly less possible)
> 
> Unlikely to be either of those. My guess is its the reiserfs stuff interacting
> with the 2.2 VM code badly. 2.2.19pre8 fixes the VM behaviour in the general
> case and that might well make it handle the extra vm pressure reiserfs causes
> 
But I got the same VM error when I was testing on an ext2 partition
under stock kernel (without any external patches).

> Certainly I'd try 2.2.19pre3 or higher. I don't think its hardware or
> reiserfs problems
> 
> 
> 
OK, I'll give 2.2.19pre8 a try.

-- 
Wenzhuo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

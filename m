Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130327AbQKWVoE>; Thu, 23 Nov 2000 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130343AbQKWVnz>; Thu, 23 Nov 2000 16:43:55 -0500
Received: from mail.zmailer.org ([194.252.70.162]:41741 "EHLO zmailer.org")
        by vger.kernel.org with ESMTP id <S130361AbQKWV3K>;
        Thu, 23 Nov 2000 16:29:10 -0500
Date: Thu, 23 Nov 2000 22:59:00 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
Message-ID: <20001123225900.E28963@mea-ext.zmailer.org>
In-Reply-To: <20001123205731.A26914@gruyere.muc.suse.de> <Pine.LNX.4.10.10011231235170.1338-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10011231235170.1338-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 23, 2000 at 12:38:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 12:38:55PM -0800, Linus Torvalds wrote:
... 
> In fact, almost all filesystems do this at some point. ext2 does it for
> directories too, for some very similar reasons that isofs does. See
> fs/ext2/dir.c:
> 
> 	blk = (filp->f_pos) >> EXT2_BLOCK_SIZE_BITS(sb);
> 
> (and don't ask me about the extraneous parenthesis. I bet some LISP
> programmer felt alone and decided to make it a bit more homey).
> 
> 		Linus

   Propably some programmer has been bitten once too many times with
   C's operator precedence rules, which only affect more complicated
   expressions -- and thus are used rarely, and not remembered well.
   (Or perhaps rememberance is felt to be weak, and parenthesis solve it.)

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281787AbRLKQWJ>; Tue, 11 Dec 2001 11:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281779AbRLKQV7>; Tue, 11 Dec 2001 11:21:59 -0500
Received: from ns.caldera.de ([212.34.180.1]:52395 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281772AbRLKQVy>;
	Tue, 11 Dec 2001 11:21:54 -0500
Date: Tue, 11 Dec 2001 17:21:45 +0100
Message-Id: <200112111621.fBBGLj906273@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: smcameron@yahoo.com (Stephen Cameron)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cciss 2.5.0 for 2.5.1-pre9
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011211151050.12948.qmail@web12308.mail.yahoo.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011211151050.12948.qmail@web12308.mail.yahoo.com> you wrote:
>
> Here's a patch for the cciss driver in the 2.5.1-pre8 tree
> (patch also applies to 2.5.1-pre9):
<
> http://geocities.com/dotslashstar/cciss_2.5.0_for_2.5.1-pre8.txt
>
> This patch:
>
> * adds support for SCSI tape drives. 
> * adds support for dynamically adding and removing      
>   logical volumes on the fly.

 * sets hardsectsizes to '0' for invalid volumes, causing devisions by zero
   in ll_rw_block().
 * backs out random fixes done in the mainline


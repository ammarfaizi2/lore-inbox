Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWDRHpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWDRHpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 03:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWDRHpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 03:45:55 -0400
Received: from TYO206.gate.nec.co.jp ([202.32.8.206]:29406 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751382AbWDRHpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 03:45:55 -0400
Message-ID: <019901c662bc$1c4c1640$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>, <Ext2-devel@lists.sourceforge.net>
References: <20060413161227sho@rifu.tnes.nec.co.jp> <20060413162028.GA23452@thunk.org>
Subject: Re: [Ext2-devel] [RFC][15/21]e2fsprogs modify variables for bitmap to exceed 2G
Date: Tue, 18 Apr 2006 16:45:44 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ted

> We could bump the major version number, but what I'd much rather do is
> to create new functions which use the 64-bit blk64_t (i.e.,
> ext2fs_mark_block_bitmap2).  This will make the patches much bigger,
> but it allows us to preserve backwards compatibility.

I'm trying to add new functions which use the 64-bit block number in
e2fsprogs.  But I think the name "ext2fs_mark_blocks_bitmap2" is rather
obscure.  How about adding "_64" to the end of the name? (i.e. ext2fs_
mark_block_bitmap_64 for ext2fs_mark_block_bitmap)

Cheers, sho

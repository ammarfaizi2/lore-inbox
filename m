Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284160AbRLKW17>; Tue, 11 Dec 2001 17:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284156AbRLKW1t>; Tue, 11 Dec 2001 17:27:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42629 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284143AbRLKW1k>;
	Tue, 11 Dec 2001 17:27:40 -0500
Date: Tue, 11 Dec 2001 14:27:14 -0800 (PST)
Message-Id: <20011211.142714.115908324.davem@redhat.com>
To: anton@samba.org
Cc: axboe@suse.de, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Scsi problems in 2.5.1-pre9
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011211221747.GB30520@krispykreme>
In-Reply-To: <20011211212802.GA30520@krispykreme>
	<20011211.140409.21593464.davem@redhat.com>
	<20011211221747.GB30520@krispykreme>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Wed, 12 Dec 2001 09:17:47 +1100
    
   > In that case you perhaps should be defining DMA_CHUNK_SIZE in
   > asm/dma.h :-)
   
   Hmm I have it defined, just not in dma.h :) I'll fix it now and retest.

Oh nevermind then, the location really is almost arbitrary.
As long as scsi_merge.c sees it.

Note this is one area Jens hasn't been able to test and I've been
trying first to solidify my sparc64 setup without DMA_CHUNK_SIZE
defined.

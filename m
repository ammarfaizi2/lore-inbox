Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285122AbRLLJcL>; Wed, 12 Dec 2001 04:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285125AbRLLJcA>; Wed, 12 Dec 2001 04:32:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25984 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285122AbRLLJbs>;
	Wed, 12 Dec 2001 04:31:48 -0500
Date: Wed, 12 Dec 2001 01:31:35 -0800 (PST)
Message-Id: <20011212.013135.48803991.davem@redhat.com>
To: axboe@suse.de
Cc: anton@samba.org, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Scsi problems in 2.5.1-pre9
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011212092148.GW13498@suse.de>
In-Reply-To: <20011212090253.GR13498@suse.de>
	<20011212.011559.21594482.davem@redhat.com>
	<20011212092148.GW13498@suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 12 Dec 2001 10:21:48 +0100

   On Wed, Dec 12 2001, David S. Miller wrote:
   > There still are problems even after this fix.
   > 
   > In fact the failures look identical to what I was seeing
   > before, first dbench from single user is insta-crash.
   
   DMA_CHUNK_SIZE only, or regardless?

DMA_CHUNK_SIZE is the only thing causing failures for me
now.

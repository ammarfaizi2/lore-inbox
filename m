Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285191AbRLMV2P>; Thu, 13 Dec 2001 16:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285193AbRLMV1z>; Thu, 13 Dec 2001 16:27:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8581 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285192AbRLMV1x>;
	Thu, 13 Dec 2001 16:27:53 -0500
Date: Thu, 13 Dec 2001 13:27:34 -0800 (PST)
Message-Id: <20011213.132734.38711065.davem@redhat.com>
To: lord@sgi.com
Cc: gibbs@scsiguy.com, axboe@suse.de, LB33JM16@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1008278244.22208.12.camel@jen.americas.sgi.com>
In-Reply-To: <200112132048.fBDKmog10485@aslan.scsiguy.com>
	<1008277112.22093.7.camel@jen.americas.sgi.com>
	<1008278244.22208.12.camel@jen.americas.sgi.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steve Lord <lord@sgi.com>
   Date: 13 Dec 2001 15:17:24 -0600
   
   OK, I can confirm this fixes it for me. A side not for Jens, this still
   pushes the scsi layer into those DMA shortage messages:

Yes we know, once Jens finishes up his work on using a mempool for the
scatterlist allocations this problem will dissapate.

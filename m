Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTANGg3>; Tue, 14 Jan 2003 01:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267477AbTANGg3>; Tue, 14 Jan 2003 01:36:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17826 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261645AbTANGg2>;
	Tue, 14 Jan 2003 01:36:28 -0500
Date: Mon, 13 Jan 2003 22:35:51 -0800 (PST)
Message-Id: <20030113.223551.92684592.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Update the generic DMA API to take GFP_ flags on
 allocation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200301140606.h0E663t16883@hera.kernel.org>
References: <200301140606.h0E663t16883@hera.kernel.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
   Date: Mon, 13 Jan 2003 16:26:50 +0000

   ChangeSet 1.930.8.1, 2003/01/13 10:26:50-06:00, jejb@raven.il.steeleye.com
   
   	Update the generic DMA API to take GFP_ flags on allocation
   	
   	dma_alloc_[non]coherent now takes the GFP_ flags as the last argument.
   	The flags passed in may not interfere with the memory zone.
   
   
What about platforms that can only use GFP_ATOMIC due to
implementation side issues?  Is that "OK"?

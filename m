Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290808AbSBLHOA>; Tue, 12 Feb 2002 02:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290809AbSBLHNu>; Tue, 12 Feb 2002 02:13:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290808AbSBLHNg>;
	Tue, 12 Feb 2002 02:13:36 -0500
Date: Mon, 11 Feb 2002 23:11:52 -0800 (PST)
Message-Id: <20020211.231152.130238010.davem@redhat.com>
To: axboe@suse.de
Cc: reddog83@chartermi.net, paulkf@microgate.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020212075636.T729@suse.de>
In-Reply-To: <001701c1b312$24448ca0$0c00a8c0@diemos>
	<auto-000058467594@front1.chartermi.net>
	<20020212075636.T729@suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Tue, 12 Feb 2002 07:56:36 +0100

   On Mon, Feb 11 2002, reddog83 wrote:
   > Paul-
   > That is understandable. I had  the same guess as you when I made this patch. 
   > Why is ths synclink.c driver using DMA Mapping. After I took that line out I 
   > was fine becuase my system is fine. 
   
   The "real" fix for synclink is just something like this, afaics.
   
It is a PCI driver Jens, this change is not correct.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282912AbRLMAHU>; Wed, 12 Dec 2001 19:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282914AbRLMAHA>; Wed, 12 Dec 2001 19:07:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12167 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282912AbRLMAGy> convert rfc822-to-8bit;
	Wed, 12 Dec 2001 19:06:54 -0500
Date: Wed, 12 Dec 2001 16:06:31 -0800 (PST)
Message-Id: <20011212.160631.14975630.davem@redhat.com>
To: groudier@free.fr
Cc: andrea@suse.de, axboe@suse.de, gibbs@scsiguy.com, LB33JM16@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011212181507.T1853-100000@gerard>
In-Reply-To: <20011212143213.E4801@athlon.random>
	<20011212181507.T1853-100000@gerard>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Wed, 12 Dec 2001 18:22:30 +0100 (CET)
   
   PCI was intended to be implemented as a LOCAL BUS with all agents on the
   LOCAL BUS being able to talk with any other agent using a flat addressing
   scheme. Your PCI thing does not look like true PCI to me, but rather like
   some bad mutant that has every chance not to survive a long time.

Intentions are neither here nor there.  PCI is MORE USEFUL, because
you CAN do things like IOMMU's and treat PCI like a complete seperate
I/O bus world.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263761AbRFHBaZ>; Thu, 7 Jun 2001 21:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263766AbRFHBaQ>; Thu, 7 Jun 2001 21:30:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:918 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263761AbRFHBaJ>;
	Thu, 7 Jun 2001 21:30:09 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15136.10909.941916.674145@pizda.ninka.net>
Date: Thu, 7 Jun 2001 18:30:05 -0700 (PDT)
To: Richard Henderson <rth@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Patrick Mochel <mochel@transmeta.com>, Alan Cox <alan@redhat.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kanoj Sarcar <kanoj@google.engr.sgi.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 32-bit dma memory zone
In-Reply-To: <20010607145912.B2286@redhat.com>
In-Reply-To: <20010607153119.H1522@suse.de>
	<Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>
	<20010607145912.B2286@redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard Henderson writes:
 > On most alphas we use only one zone -- ZONE_DMA.  The iommu makes it
 > possible to do 32-bit pci to the entire memory space.
 > 
 > For those alphas without an iommu, we also set up ZONE_NORMAL.

And on sparc64 since all machines have an iommu, we use just ZONE_DMA
for everything.

Later,
David S. Miller
davem@redhat.com


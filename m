Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267827AbTBVH2Q>; Sat, 22 Feb 2003 02:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267829AbTBVH2Q>; Sat, 22 Feb 2003 02:28:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21462 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267827AbTBVH2Q>;
	Sat, 22 Feb 2003 02:28:16 -0500
Date: Fri, 21 Feb 2003 23:22:12 -0800 (PST)
Message-Id: <20030221.232212.102082055.davem@redhat.com>
To: hch@infradead.org
Cc: chas@locutus.cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cli() for net/atm/lec.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030221175702.A4224@infradead.org>
References: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil>
	<200302211740.h1LHecGi014946@locutus.cmf.nrl.navy.mil>
	<20030221175702.A4224@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Fri, 21 Feb 2003 17:57:02 +0000

   > @@ -634,6 +635,7 @@
   >          dev->get_stats = lec_get_stats;
   >          dev->set_multicast_list = NULL;
   >          dev->do_ioctl  = NULL;
   > +	spin_lock_init(&lec_arp_spinlock);
   
   This is still superflous..
   
True, Chas can you cook up a new patch with this deleted?
Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbRCAT0B>; Thu, 1 Mar 2001 14:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRCATZx>; Thu, 1 Mar 2001 14:25:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39303 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129823AbRCATZj>;
	Thu, 1 Mar 2001 14:25:39 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15006.41335.378413.427127@pizda.ninka.net>
Date: Thu, 1 Mar 2001 11:22:31 -0800 (PST)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <3A9E8628.7CCD1162@colorfullife.com>
In-Reply-To: <3A9E8628.7CCD1162@colorfullife.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred, why are you changing the cache alignment to
SMP_CACHE_BYTES?  If you read the original SLAB papers
and other documents, the code intends to color the L1
cache not the L2 or subsidiary caches.

Later,
David S. Miller
davem@redhat.com

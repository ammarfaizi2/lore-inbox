Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbRF2HFx>; Fri, 29 Jun 2001 03:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265678AbRF2HFd>; Fri, 29 Jun 2001 03:05:33 -0400
Received: from [210.77.38.126] ([210.77.38.126]:28939 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S265661AbRF2HFX>; Fri, 29 Jun 2001 03:05:23 -0400
Date: Fri, 29 Jun 2001 15:06:01 +0800
From: michaelc <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <3620762046.20010629150601@turbolinux.com.cn>
To: linux-kernel@vger.kernel.org
Subject: about kmap_high function
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I found that the kmap_high function didn't call __flush_tlb_one()
when it mapped a highmem page sucessfully, and I think it maybe
cause the problem that TLB may store obslete page table entries, but
the kmap_atomic() function do call the __flush_tlb_one(), someone tell
me what's the differenc between the kmap_atomic and kmap_high except
that kmap_atomic can be used in IRQ contexts. I appreciate in advance.

-- 
Best regards,
 michaelc                          mailto:michaelc@turbolinux.com.cn



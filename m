Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266701AbSKUNZB>; Thu, 21 Nov 2002 08:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbSKUNZB>; Thu, 21 Nov 2002 08:25:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:18834 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266701AbSKUNZA>;
	Thu, 21 Nov 2002 08:25:00 -0500
Date: Thu, 21 Nov 2002 13:30:23 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE_SHIFT value for P4 ?
Message-ID: <20021121133023.GE9883@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121142223.00b546c0@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021121142223.00b546c0@mail.dns-host.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 02:25:54PM +0100, Margit Schubert-While wrote:
 > Andi,
 > L2 cache lines = L2 cache size ?

No.

 > This P4 has got 512KB L2 cache.

That 512KB is divided into 'lines' of n bytes.
Where n is the L1_CACHE_SHIFT value. (Or should be).
x86info will tell you the line size. (Its also printk'd at boot up iirc)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

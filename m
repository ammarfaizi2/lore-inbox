Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSKUNRl>; Thu, 21 Nov 2002 08:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSKUNRl>; Thu, 21 Nov 2002 08:17:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:12690 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266660AbSKUNRk>;
	Thu, 21 Nov 2002 08:17:40 -0500
Date: Thu, 21 Nov 2002 13:23:02 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE_SHIFT value for P4 ?
Message-ID: <20021121132302.GD9883@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@suse.de>, Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121130236.00b15370@mail.dns-host.com.suse.lists.linux.kernel> <p73y97nt6fp.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73y97nt6fp.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 02:10:02PM +0100, Andi Kleen wrote:

 > The P4 has 128byte L2 cache lines (2^7). The L1 apparently has smaller lines.

Not mine:

L2 unified cache:
	Size: 512KB	Sectored, 8-way associative.
	line size=64 bytes.

Someone (Manfred?) pointed out a chapter in the P4 system programmer guide about
this last time I brought it up. I forget the reasoning, I'll see if I can dig it out..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSKTSIm>; Wed, 20 Nov 2002 13:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKTSIl>; Wed, 20 Nov 2002 13:08:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:11144 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261292AbSKTSIl>;
	Wed, 20 Nov 2002 13:08:41 -0500
Date: Wed, 20 Nov 2002 18:13:59 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc2 strange L1 cache values
Message-ID: <20021120181359.GA10698@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021120190203.00b5acf0@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021120190203.00b5acf0@mail.dns-host.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 07:05:06PM +0100, Margit Schubert-While wrote:
 > Any ideas anybody ?
 > <6>CPU: L1 I cache: 0K, L1 D cache: 8K
 > <6>CPU: L2 cache: 512K
 > <6>Intel machine check architecture supported.
 > <6>Intel machine check reporting enabled on CPU#0.
 > <7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
 > <7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
 > <4>CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04

P4 Trace cache isn't recognised.
Apply ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.4/2.4.20/descriptors.diff

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbTBLTol>; Wed, 12 Feb 2003 14:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbTBLTok>; Wed, 12 Feb 2003 14:44:40 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:56208 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267617AbTBLTok>;
	Wed, 12 Feb 2003 14:44:40 -0500
Date: Wed, 12 Feb 2003 19:49:12 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andreas Arens <ari@goron.de>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] AMD IDE oops in current 2.4-ac
Message-ID: <20030212194912.GA24138@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andreas Arens <ari@goron.de>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
References: <20030212204815.A8782@www.goron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212204815.A8782@www.goron.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 08:48:15PM +0100, Andreas Arens wrote:
 > Current 2.4.21-pre4-ac kernels oops in amd74xx.c with
 > certain chipsets due to a table order problem. The
 > problem is correctly detected by a BUG() in the pci probe
 > routine, which should trigger for all non-nforce chipsets.

If moving entries in the table caused a bug, adding new entries
could do the same too perhaps ? This sounds quite fragile
based on your description & diff.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

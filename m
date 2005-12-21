Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVLUJWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVLUJWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVLUJWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:22:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58536
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932328AbVLUJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:22:11 -0500
Date: Wed, 21 Dec 2005 01:22:12 -0800 (PST)
Message-Id: <20051221.012212.65592069.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull
 on x86_64 machines ?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43A91C57.20102@cosmosbay.com>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>
	<43A91C57.20102@cosmosbay.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Wed, 21 Dec 2005 10:11:51 +0100

> Could some of you post the result of the following command on your machines :

sparc64, PAGE_SIZE=8192, L1_CACHE_BYTES=32

size-131072            0      0 131072  
size-65536            13     13  65536  
size-32768             2      2  32768  
size-16384             2      2  16384  
size-8192             67     67   8192  
size-4096             75     76   4096  
size-2048            303    308   2048  
size-1024            176    176   1024  
size-512             251    255    512  
size-256             217    217    256  
size-192            1230   1230    192  
size-128             106    122    128  
size-96             1098   1134     96  
size-64            29387  30226     64  

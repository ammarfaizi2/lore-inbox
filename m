Return-Path: <linux-kernel-owner+w=401wt.eu-S1751399AbXAFNKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXAFNKK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXAFNKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:10:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:54751 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbXAFNKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:10:09 -0500
Date: Sat, 6 Jan 2007 15:10:05 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: Hugh Dickins <hugh@veritas.com>
cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: fix double-free in fallback_alloc
In-Reply-To: <Pine.LNX.4.64.0701052037100.4444@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0701061509270.6034@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0701051127180.17184@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0701052037100.4444@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Hugh Dickins wrote:
> The main thing is to make sure that your patch doesn't end up applied
> to a tree with my patch in, since that would then be a (rare) leak.

Yeah, I'll wait for your patch to hit Linus' tree and rediff against that. 
Thanks.
 
			Pekka

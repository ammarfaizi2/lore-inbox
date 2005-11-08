Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVKHHfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVKHHfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVKHHfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:35:07 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63944 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965070AbVKHHfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:35:05 -0500
Date: Tue, 8 Nov 2005 09:34:48 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Roland Dreier <rolandd@cisco.com>
cc: Matthew Dobson <colpatch@us.ibm.com>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
In-Reply-To: <52mzkfrily.fsf@cisco.com>
Message-ID: <Pine.LNX.4.58.0511080932460.9530@sbz-30.cs.Helsinki.FI>
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com>
 <52mzkfrily.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Roland Dreier wrote:

>     > * Replace a constant (4096) with what it represents (PAGE_SIZE)
> 
> This seems dangerous.  I don't pretend to understand the slab code,
> but the current code works on architectures with PAGE_SIZE != 4096.
> Are you sure this change is correct?

Looks ok to me except that it should be a separate patch (it is not a 
trivial cleanup because it changes how the code works).

			Pekka

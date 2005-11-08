Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbVKHHjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbVKHHjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVKHHjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:39:11 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:5577 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964887AbVKHHjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:39:10 -0500
Date: Tue, 8 Nov 2005 09:39:08 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Inline 3 functions
In-Reply-To: <436FF894.8090204@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0511080937060.9530@sbz-30.cs.Helsinki.FI>
References: <436FF51D.8080509@us.ibm.com> <436FF894.8090204@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Matthew Dobson wrote:
> I found three functions in slab.c that have only 1 caller (kmem_getpages,
> alloc_slabmgmt, and set_slab_attr), so let's inline them.

Why? They aren't on the hot path and I don't see how this is an 
improvement...

			Pekka

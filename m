Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWAaHi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWAaHi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWAaHi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:38:28 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:33770 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964867AbWAaHi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:38:27 -0500
Date: Tue, 31 Jan 2006 09:38:25 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 0/8] Create and Use common mempool allocators (Take 2)
In-Reply-To: <1138656208.20704.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0601310911390.20783@sbz-30.cs.Helsinki.FI>
References: <1138656208.20704.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006, Matthew Dobson wrote:
> In the course of working on some patches to implement subsystem-wide critical
> pools through the existing mempool API, I created the following patches which
> create 3 new common mempool allocators (mempool_alloc_pages, mempool_kmalloc &
> mempool_kzalloc) and freers.  The following 6 patches add these new common
> allocators and convert existing mempool users to use these common allocators,
> where possible.  Optionally, the last 2 patches in this series add and use a
> wrapper for the common case of creating a slab-based mempool.

Looks good to me.

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

			Pekka

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268337AbUIGPxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268337AbUIGPxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUIGPwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:52:02 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55730 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268445AbUIGPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:47:42 -0400
Date: Tue, 7 Sep 2004 16:47:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Hellwig <hch@lst.de>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't export shmem_file_setup
In-Reply-To: <20040907143901.GB8606@lst.de>
Message-ID: <Pine.LNX.4.44.0409071644090.3043-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, Christoph Hellwig wrote:
> -
> -EXPORT_SYMBOL(shmem_file_setup);

Agreed.  It's global for SysV IPC, but that's in or out, never modular.

Hugh


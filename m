Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVBLPLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVBLPLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 10:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVBLPLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 10:11:55 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:58047 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261413AbVBLPLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 10:11:53 -0500
Subject: Re: [PATCH] kmalloc() bug in pci-dma.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050211172439.A21261@unix-os.sc.intel.com>
References: <20050211172439.A21261@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Sat, 12 Feb 2005 10:11:43 -0500
Message-Id: <1108221103.5736.9.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 17:24 -0800, Venkatesh Pallipadi wrote:
> After burning my fingers with a similar mistake in one of the patches 
> that I am working on, I did a quick grep to find out all faulty kmalloc() 
> calls and found this.
> 
> dma_declare_coherent_memory() is calling kmalloc with wrong arguments. 
> Attached patch fixes this.

Oh Wow, did I really do that ... brown paper bag time for me, I suppose.

> Please apply.

Andrew, please put it in.

James



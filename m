Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUEFKrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUEFKrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUEFKq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:46:28 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:43025 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262031AbUEFKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:44:20 -0400
Date: Thu, 6 May 2004 11:44:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sourav Sen <souravs@india.hp.com>
Cc: Matt_Domsch@dell.com, matthew.e.tolentino@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040506114414.A14543@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sourav Sen <souravs@india.hp.com>, Matt_Domsch@dell.com,
	matthew.e.tolentino@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <003801c43347$812a1590$39624c0f@india.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <003801c43347$812a1590$39624c0f@india.hp.com>; from souravs@india.hp.com on Thu, May 06, 2004 at 02:22:46PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
> Hi,
> 
> The following simple patch creates a read-only file
> "memmap" under <mount point>/firmware/efi/ in sysfs
> and exposes the efi memory map thru it.

doesn't exactly fit into the one value per file approach, does it?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUEFQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUEFQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUEFQp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:45:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:51868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261234AbUEFQpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:45:19 -0400
Date: Thu, 6 May 2004 09:40:40 -0700
From: Greg KH <greg@kroah.com>
To: Sourav Sen <souravs@india.hp.com>
Cc: Matt_Domsch@dell.com, matthew.e.tolentino@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040506164040.GA15371@kroah.com>
References: <003801c43347$812a1590$39624c0f@india.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801c43347$812a1590$39624c0f@india.hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
> 
> The following simple patch creates a read-only file
> "memmap" under <mount point>/firmware/efi/ in sysfs
> and exposes the efi memory map thru it.

No, data in this kind of format does not belong in sysfs.

thanks,

greg k-h

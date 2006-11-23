Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933285AbWKWJXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933285AbWKWJXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbWKWJXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:23:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:51933 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S933285AbWKWJXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:23:37 -0500
Date: Thu, 23 Nov 2006 00:39:20 -0800
From: Greg KH <greg@kroah.com>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       myles@mouselemur.cs.byu.edu
Subject: Re: PCI: check szhi when sz is 0 when 64 bit iomem bigger than 4G
Message-ID: <20061123083920.GA21211@kroah.com>
References: <5986589C150B2F49A46483AC44C7BCA4130683@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4130683@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 07:29:24PM -0800, Lu, Yinghai wrote:
> [PATCH] PCI: check szhi when sz is 0 when 64 bit iomem bigger than 4G
> 
> If the PCI device is 64-bit memory and has a size of 0xnnnnnnnn00000000 then
> pci_read_bases() will incorrectly assume that it has a size of zero.

I'm dropping this patch, as the compiler warnings show that something is
still wrong here.

Can you please send me the latest version of this patch, due to all of
the different changes that it has gone through, I'm a bit confused...

thanks,

greg k-h

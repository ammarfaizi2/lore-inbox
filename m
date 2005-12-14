Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVLNAGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVLNAGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 19:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVLNAGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 19:06:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56973
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030353AbVLNAGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 19:06:49 -0500
Date: Tue, 13 Dec 2005 16:06:21 -0800 (PST)
Message-Id: <20051213.160621.98128378.davem@davemloft.net>
To: bjorn.helgaas@hp.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: [patch 1/2] /dev/mem __HAVE_PHYS_MEM_ACCESS_PROT tidy-up
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200512131656.11601.bjorn.helgaas@hp.com>
References: <200512131656.11601.bjorn.helgaas@hp.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Tue, 13 Dec 2005 16:56:11 -0700

> Tidy up __HAVE_PHYS_MEM_ACCESS_PROT usage to make mmap_mem() easier to read.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

It would be _really_ easy to read if the default implementation
lived in some asm-generic/foo.h header file :-)

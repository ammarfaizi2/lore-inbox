Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVCQG0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVCQG0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 01:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVCQG0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 01:26:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261847AbVCQG0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 01:26:43 -0500
Date: Wed, 16 Mar 2005 22:26:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ju, Seokmann" <sju@lsil.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, sju@lsil.com
Subject: Re: [ANNOUNCE][PATCH] drivers/scsi/megaraid/megaraid_{mm,mbox}
Message-Id: <20050316222619.548e82b6.akpm@osdl.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570366276A@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570366276A@exa-atlanta>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ju, Seokmann" <sju@lsil.com> wrote:
>
>  Here is a patch for megaraid_mm/megaraid_mbox driver which makes it
>  2.20.4.6.
>  Following is brief on the changes:
>  1. Added compat_ioctl
>  2. Reordered inputs on memset
>  3. Convert pci_module_iit to pci_register_driver 
>  4. Added DMA_{32,64}BIT_MASK 5. Modified PCI PnP ID table

Some of these things have already been done in Linus's post-2.6.11 tree and
you patch throws lots of rejects.  Please always work against the most
recent kernel - 2.6.11 is very out of date.

The patch was severely wordwrapped.  Please fix your email client and send
a test patch to yourself and ensure that it still applies OK.

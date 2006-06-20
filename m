Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWFTRNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWFTRNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWFTRNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:13:21 -0400
Received: from xenotime.net ([66.160.160.81]:43653 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751430AbWFTRNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:13:20 -0400
Date: Tue, 20 Jun 2006 10:16:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines
Message-Id: <20060620101605.0240a685.rdunlap@xenotime.net>
In-Reply-To: <4497F85B.7010409@ed-soft.at>
References: <4497F85B.7010409@ed-soft.at>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 15:30:03 +0200 Edgar Hucek wrote:

> Fix EFI boot on 32 bit machines with pcie port.
> Efi machines does not have an e820 memory map.
> 
> Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

Darn, I was going to comment on the patch, but the attachment
isn't quoted... :(


1.  if you modify this patch, change
+	if(!efi_enabled) {
to
	if (!efi_enabled) {
to be compatible with Linux coding style.

2.  There are ways to send inline patches with thunderbird.
Take a look at these:
http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
http://lkml.org/lkml/2005/12/27/191
http://lists.osdl.org/pipermail/kernel-janitors/2006-June/006478.html

Thanks,
---
~Randy

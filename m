Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbUAWIuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 03:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUAWIuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 03:50:21 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:7060 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S265321AbUAWIuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 03:50:18 -0500
To: "Leonid Grossman" <leonid.grossman@s2io.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'ravinandan arakali'" <ravinandan.arakali@s2io.com>
Subject: Re: pci_alloc_consistent()
References: <000101c3e154$949dd520$7310100a@S2IOtech.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 23 Jan 2004 03:50:14 -0500
In-Reply-To: <000101c3e154$949dd520$7310100a@S2IOtech.com>
Message-ID: <yq07jzj2gmx.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Leonid" == Leonid Grossman <leonid.grossman@s2io.com> writes:

Leonid> Are there any known issues with pci_alloc_consistent()
Leonid> allocating more than 1MB?  One of our developers seems to
Leonid> recall a thread but we can't find it...

[snip]

Leonid> Is this a known problem? The system is 2-way Itanium, running
Leonid> 2.4.21 kernel.

Leonid,

What type of Itanium box? It's possible what you're seeing is caused
by a bug in the IOMMU code, but we would need to know which one (HP,
SGI or someone else's).

Cheers,
Jes

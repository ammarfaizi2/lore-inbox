Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVCPRnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVCPRnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVCPRnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:43:50 -0500
Received: from [81.2.110.250] ([81.2.110.250]:4020 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261320AbVCPRnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:43:49 -0500
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       riel@redhat.com, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
In-Reply-To: <20050316143130.GA21959@infradead.org>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
	 <20050316143130.GA21959@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110994839.1295.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 16 Mar 2005 17:40:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-16 at 14:31, Christoph Hellwig wrote:
> It's bogus either way.  You must never use virt_to_phys or virt_to_bus
> for bus address.  For systems with an IOMMU there's no 1:1 mapping.

The AGPGART _is_ the IOMMU.

Alan


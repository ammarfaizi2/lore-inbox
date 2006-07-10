Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWGJLbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWGJLbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWGJLbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:31:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51123 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932416AbWGJLba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:31:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060708111243.28664.74956.sendpatchset@skynet.skynet.ie> 
References: <20060708111243.28664.74956.sendpatchset@skynet.skynet.ie>  <20060708111042.28664.14732.sendpatchset@skynet.skynet.ie> 
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
       linux-mm@kvack.org, ak@suse.de, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/6] Account for memmap and optionally the kernel image as holes 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 10 Jul 2006 12:30:55 +0100
Message-ID: <7220.1152531055@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:

> +unsigned long __initdata dma_reserve;

Should this be static?  Or should it be predeclared in a header file
somewhere?

David

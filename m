Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVK2GDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVK2GDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVK2GDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:03:40 -0500
Received: from holomorphy.com ([66.93.40.71]:3011 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1751301AbVK2GDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:03:39 -0500
Date: Mon, 28 Nov 2005 22:03:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix crash when ptrace poking hugepage areas
Message-ID: <20051129060305.GC2240@holomorphy.com>
References: <20051129050628.GB12498@localhost.localdomain> <20051128211807.66817481.akpm@osdl.org> <20051129054136.GA16852@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129054136.GA16852@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 04:41:36PM +1100, David Gibson wrote:
> This patch fixes the bug by only calling set_page_dirty() from
> access_process_vm() if the page is not a compound page.  We already
> use a similar fix in bio_set_pages_dirty() for the case of direct io
> to hugepages.
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: William Irwin <wli@holomorphy.com>


-- wli

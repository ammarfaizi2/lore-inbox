Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWHaR3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWHaR3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHaR3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:29:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:59331 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932218AbWHaR3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:29:13 -0400
Subject: Re: [patch 0/6] RFC: fault-injection capabilities (v2)
From: Josh Triplett <josht@us.ibm.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org, okuji@enbug.org
In-Reply-To: <20060831100756.866727476@localhost.localdomain>
References: <20060831100756.866727476@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 10:29:20 -0700
Message-Id: <1157045360.4366.4.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 19:07 +0900, Akinobu Mita wrote:
> This patch set provides some fault-injection capabilities.
> 
> - kmalloc failures
> 
> - alloc_pages() failures
> 
> - disk IO errors
> 
> We can see what really happens if those failures happen.

Looks very useful for testing error paths; nice work.

Should this perhaps taint the kernel when used?

- Josh Triplett



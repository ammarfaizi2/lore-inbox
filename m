Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVCAApN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVCAApN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVCAAnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:43:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:60907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261164AbVCAAnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:43:07 -0500
Date: Mon, 28 Feb 2005 16:42:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: kmannth@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] prepare x86/ppc64 DISCONTIG code for hotplug
Message-Id: <20050228164234.38cb774c.akpm@osdl.org>
In-Reply-To: <1109616858.6921.39.camel@localhost>
References: <1109616858.6921.39.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> Subject pretty much says it all.  Descriptions are in the individual
> patches.  These patches replace the
> "allow-hot-add-enabled-i386-numa-box-to-boot.patch" which is currently
> in -mm.  Please drop it.  
> 
> They apply to 2.6.11-rc5 after a few patches from -mm which conflicted:
> 
> 	stop-using-base-argument-in-__free_pages_bulk.patch
> 	consolidate-set_max_mapnr_init-implementations.patch
> 	refactor-i386-memory-setup.patch
> 	remove-free_all_bootmem-define.patch
> 	mostly-i386-mm-cleanup.patch
> 
> Boot-tested on plain x86 laptop, NUMAQ, and Summit.  These probably
> deserve to stay in -mm for a release or two.
> 

Most of these patches needed little fixups due to other patches which you
folks have already sent me:

	allow-hot-add-enabled-i386-numa-box-to-boot
	refactor-i386-memory-setup
	consolidate-set_max_mapnr_init-implementations

I'll try to get a -mm out this evening - please retest this stuff.

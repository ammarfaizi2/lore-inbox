Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263407AbUDVEzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUDVEzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 00:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUDVEzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 00:55:55 -0400
Received: from ns.suse.de ([195.135.220.2]:11752 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263407AbUDVEzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 00:55:54 -0400
Date: Thu, 22 Apr 2004 06:52:15 +0200
From: Andi Kleen <ak@suse.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       mbligh@aracnet.com, akpm@osdl.org
Subject: Re: [PATCH] include/linux/gfp.h cleanup for NUMA API
Message-ID: <20040422045215.GA20728@wotan.suse.de>
References: <408645AA.5050400@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408645AA.5050400@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 02:58:02AM -0700, Matthew Dobson wrote:
> Andi,
> 	Here's a few cleanups to include/linux/gfp.h
> 
> 1) Move the extern of alloc_pages_current() into #ifdef CONFIG_NUMA. 
> The only references to the function are in NUMA code in mempolicy.c
> 
> 2) Remove the definitions of __alloc_page_vma().  They aren't used.
> 
> 3) Move forward declaration of struct vm_area_struct to top of file.

I already did (2). Rest looks ok too.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271180AbUJVCXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271180AbUJVCXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271165AbUJVCVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:21:06 -0400
Received: from holomorphy.com ([207.189.100.168]:43966 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271211AbUJVCTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:19:15 -0400
Date: Thu, 21 Oct 2004 19:19:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make drivers/char/mem.c use remap_pfn_range()
Message-ID: <20041022021908.GI17038@holomorphy.com>
References: <200410220206.i9M26gUi016689@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410220206.i9M26gUi016689@hera.kernel.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 10:25:17PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2036.1.25, 2004/10/21 15:25:17-07:00, torvalds@ppc970.osdl.org
> 	Make drivers/char/mem.c use remap_pfn_range()
> 	Rather than the deprecated remap_page_range() function
> 	that can't handle all of the PFN range anyway.
> 	Also, since that will now mark the vma as being special,
> 	there's no need to do it in mmap_mem() any more.
>  mem.c |   19 +++++++------------
>  1 files changed, 7 insertions(+), 12 deletions(-)

Odd. I doublechecked the patches I submitted and they actually
covered this.


-- wli

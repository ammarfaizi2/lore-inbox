Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUFFJLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUFFJLO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUFFJLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:11:14 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:44964 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S263154AbUFFJLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:11:13 -0400
Message-ID: <40C2F005.5010600@codeweavers.com>
Date: Sun, 06 Jun 2004 19:20:53 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com> <20040606073241.GA6214@infradead.org> <40C2E045.8090708@codeweavers.com> <20040606081021.GA6463@infradead.org> <40C2E5DC.8000109@codeweavers.com> <20040606083924.GA6664@infradead.org> <20040606084326.GA6716@infradead.org>
In-Reply-To: <20040606084326.GA6716@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:

> And btw, if you'd have read the whole thread you'd have seen that I argued
> against mergign the randomization and address space layout changes into
> 2.6, and such changes during stable series are bad.  But your still much
> better of getting your code fixed properly, and thus pretty much means
> havign your own binary format handler in the kernel that sets up the address
> space in a windows compatible way.

The staticly linked userspace binary loader seems like the best solution 
to me.  For binary distributions of Wine there's no need to compile 
kernels or modules at install time, no need to be root to install and no 
need for us to write and maintain kernel code for N different operating 
systems.  Please let me know if you think of a way to break this solution ;)

Anyway, thanks for at least trying to keep these kind of changes for new 
major versions.

Mike

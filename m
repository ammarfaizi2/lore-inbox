Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSETBKU>; Sun, 19 May 2002 21:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSETBKT>; Sun, 19 May 2002 21:10:19 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:64470 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315616AbSETBKS>;
	Sun, 19 May 2002 21:10:18 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15592.19630.175916.291284@argo.ozlabs.ibm.com>
Date: Mon, 20 May 2002 11:09:02 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.44.0205191742130.10180-100000@home.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Finally, I haven't really heard anything back from the "strange" VM
> architectures (ie sparc v8 and PPC) other than Davem's buy-in that the
> basic approach should work ok for them.

Looking at it now. :)

My only comment at this stage is that I would like to have the address
passed to tlb_remove_page, as it used to be, so that I can find and
clear the PTEs in the MMU hash table efficiently when the buffer in
the mmu_gather_t fills up, before freeing the pages.

Paul.

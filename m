Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUBFDxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUBFDxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:53:33 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:10190 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266435AbUBFDwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:52:55 -0500
Date: Thu, 5 Feb 2004 22:52:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nikolay Igotti <nike@lyola.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: memmove syscall
In-Reply-To: <4020E64F.8020006@lyola.com>
Message-ID: <Pine.LNX.4.44.0402052252130.5933-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Nikolay Igotti wrote:

>    Maybe this is kinda crazy (or known) idea, but why don't we create
> syscall allowing large copies by just manipulating MMU page table, i.e.

>    return mmu_remap_pages(src,  dst, size / PAGE_SIZE);

Did you look at mremap(2) ?

Linux has had mremap for a very very long time...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


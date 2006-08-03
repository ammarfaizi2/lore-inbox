Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWHCUi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWHCUi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWHCUi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:38:56 -0400
Received: from 1wt.eu ([62.212.114.60]:20493 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751309AbWHCUi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:38:56 -0400
Date: Thu, 3 Aug 2006 22:29:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803202929.GA8776@1wt.eu>
References: <44D1CC7D.4010600@vmware.com> <1154611272.23655.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154611272.23655.71.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 02:21:12PM +0100, Alan Cox wrote:
> So how does this differ from the twice yearly recycling of the fixed
> driver ABI discussion ?
> 
> We have a facility for loading binary blobs into the kernel built from
> source, its called insmod. 

I think that the issue Zach tried to cover is the current inability to
keep the same binary module across multiple kernel versions. That's why
he compared modules<->kernel to ELF<->glibc. In that sense, he's right.
I'm very happy when I find that old binaries I built with gcc-2.7.2 in
1997 still run under my glibc-2.3.6 without any need to rebuild (and
potentially rebuild gcc-2.7.2 first).

> Alan

Willy


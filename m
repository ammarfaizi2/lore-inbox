Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSHVUoW>; Thu, 22 Aug 2002 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSHVUoW>; Thu, 22 Aug 2002 16:44:22 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:60943 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317263AbSHVUoV>; Thu, 22 Aug 2002 16:44:21 -0400
Date: Thu, 22 Aug 2002 21:48:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Bligh <mjbligh@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [patch] SImple Topology API v0.3 (1/2)
Message-ID: <20020822214826.A32384@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Martin Bligh <mjbligh@us.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <3D6537D3.3080905@us.ibm.com> <20020822202239.A30036@infradead.org> <3D654C8F.30400@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D654C8F.30400@us.ibm.com>; from colpatch@us.ibm.com on Thu, Aug 22, 2002 at 01:41:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 01:41:51PM -0700, Matthew Dobson wrote:
> The file asm/mmzone.h needs to be included in both the CONFIG_DISCONTIGMEM and 
> !CONFIG_DISCONTIGMEM cases (at least after my patch).  This just pulls the 
> #include out of the #ifdefs.

Maybe I've noticed that myself?  But why do you suddenly break every port
of execept of i386,ia64, alpha and mips64?  What is the reason your patch
needs this?


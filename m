Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268846AbUJUJLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268846AbUJUJLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUJTSUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:20:21 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:28169 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269003AbUJTSS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:18:56 -0400
Date: Wed, 20 Oct 2004 19:18:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, dhowells@redhat.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-m68k@vger.kernel.org, linux-sh@m17n.org,
       linux-arm-kernel@lists.arm.linux.org.uk, parisc-linux@parisc-linux.org,
       linux-ia64@vger.kernel.org, linux-390@vm.marist.edu,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041020181850.GA23979@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, dhowells@redhat.com,
	torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
	sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, linux-sh@m17n.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
References: <3506.1098283455@redhat.com> <20041020152957.GA21774@infradead.org> <20041020105027.54bf9e89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020105027.54bf9e89.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 10:50:27AM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > Hi Linus, Andrew,
> >  > 
> >  > The attached patch adds syscalls for almost all archs (everything barring
> >  > m68knommu which is in a real mess, and i386 which already has it).
> >  > 
> >  > It also adds 32->64 compatibility where appropriate.
> > 
> >  Umm, that patch added the damn multiplexer that had been vetoed multiple
> >  times.  Why did this happen?
> 
> Fifteen new syscalls was judged excessive and the keyfs interface was
> judged slow and bloaty.

Maybe 15 syscalls just means the API is goddamn awfull and we certainly
shouldn't merge it as-is.


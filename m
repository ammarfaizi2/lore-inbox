Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268405AbUJTPgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268405AbUJTPgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUJTPfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:35:52 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:13065 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268166AbUJTPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:30:14 -0400
Date: Wed, 20 Oct 2004 16:29:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, sparclinux@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-m68k@vger.kernel.org,
       linux-sh@m17n.org, linux-arm-kernel@lists.arm.linux.org.uk,
       parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
       linux-390@vm.marist.edu, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041020152957.GA21774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
	sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, linux-sh@m17n.org,
	linux-arm-kernel@lists.arm.linux.org.uk,
	parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
	linux-390@vm.marist.edu, linux-mips@linux-mips.org
References: <3506.1098283455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3506.1098283455@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Linus, Andrew,
> 
> The attached patch adds syscalls for almost all archs (everything barring
> m68knommu which is in a real mess, and i386 which already has it).
> 
> It also adds 32->64 compatibility where appropriate.

Umm, that patch added the damn multiplexer that had been vetoed multiple
times.  Why did this happen?


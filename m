Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUEPH7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUEPH7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUEPH7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 03:59:04 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:13071 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263338AbUEPH7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 03:59:02 -0400
Date: Sun, 16 May 2004 08:58:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Hyok S. Choi" <hyok.choi@samsung.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       linux-kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: MMUless CPU support?
Message-ID: <20040516085858.A15133@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Hyok S. Choi" <hyok.choi@samsung.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-kernel mailing-list <linux-kernel@vger.kernel.org>
References: <409E3752.3050102@snapgear.com> <20040509152414.C17714@flint.arm.linux.org.uk> <409EC97D.7030105@samsung.com> <20040510094435.B27722@flint.arm.linux.org.uk> <409F62D5.6080500@samsung.com> <20040510123124.C27722@flint.arm.linux.org.uk> <409F7341.4090207@samsung.com> <042601c43905$beed50e0$0100a8c0@SHUTTLE> <20040513174521.A10776@flint.arm.linux.org.uk> <40A493CA.7030702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40A493CA.7030702@samsung.com>; from hyok.choi@samsung.com on Fri, May 14, 2004 at 06:39:22PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 06:39:22PM +0900, Hyok S. Choi wrote:
> >And you can use assembler/linker magic to alias sys_fork to
> >sys_ni_syscall.
> >
> >Since Hyok seems to be 100% against any kind of merge, it's useless
> >even talking about this though.
> >  
> >
> Hmm, I think about the clean and well structured kind of merge. His 
> comment was useful for me. :-)
> 
> I always think almost all of tricky method to cross among codes is NO 
> good, for maintainer, code readers, porting guys and all.
> I like Vadim's method.

Where does this totally out of context post come from?  Given rmk is
Cc'ed it's probably armnommu and you're probably still arguing that
you don't want to merge the remaining tiny nommu bitws into arch/arm?

A bit more context would certainly help..

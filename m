Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVCHPMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVCHPMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVCHPMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:12:07 -0500
Received: from mail.linux-mips.org ([62.254.210.162]:47064 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S261396AbVCHPMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:12:05 -0500
Date: Tue, 8 Mar 2005 15:12:02 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, davej@redhat.com,
       torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050308151202.GB10194@linux-mips.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304032632.0a729d11.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:26:32AM -0800, Andrew Morton wrote:

> >  Looking at the http://l4x.org/k/ site, it appears that all -mm versions
> >  have broken ARM support with the defconfig, while Linus kernels at least
> >  build fine.
> 
> It's very much in an arch maintainer's interest to make sure that
> cross-compilers are easily obtainable.  Any hints?

In theory.  In practice on some platforms we need special compiler patches
which will never be accepted into gcc upstream or are restricted to
particular versions of tools.  Building crosstools is tricky and yet it
seems every moron really has to toll it's own from his private mouldy
collection of patches.  The whole tools stuff has become very much a
battlefield of it's own.

  Ralf

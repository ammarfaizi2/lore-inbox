Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUJXQt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUJXQt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUJXQqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:46:48 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:18444 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261533AbUJXPyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:54:47 -0400
Date: Sun, 24 Oct 2004 16:54:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: generic hardirq code in 2.6.10-rc1
Message-ID: <20041024155443.GA25013@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arch@vger.kernel.org
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o generic irq subsystem: core
>   o generic irq subsystem: x86 port
>   o generic irq subsystem: x86_64 port
>   o generic irq subsystem: ppc port
>   o generic irq subsystem: ppc64 port

Btw, it would be nice if all architectures that have more or less
a copy of the i386 irq.c could switch to the generic code.

That would be:  alpha,ia64, m32r, mips, sh, sh64, um, v850

and possibly cris (it currently has a simplified version)

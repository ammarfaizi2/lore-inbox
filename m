Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263279AbUJ2Lrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbUJ2Lrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbUJ2Lro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:47:44 -0400
Received: from canuck.infradead.org ([205.233.218.70]:54543 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263284AbUJ2LnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:43:14 -0400
Subject: Re: [PATCH[ Export __PAGE_KERNEL_EXEC for modules (vmmon)
From: Arjan van de Ven <arjan@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041029113837.GD10837@vana.vc.cvut.cz>
References: <20041028221148.GE24972@vana.vc.cvut.cz>
	 <1099040620.2641.11.camel@laptop.fenrus.org>
	 <20041029113837.GD10837@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1099050178.2641.20.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 29 Oct 2004 13:42:58 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 13:38 +0200, Petr Vandrovec wrote:
> ????
> 
> Due to rule that not everything should be in kernel, userspace
> picks one of codes needed to switch processor from currently used
> mode  & address space to mode VMware needs (ia32 => long, long => ia32, 
> PAE <=> non-PAE + cr3 + gdt + idt) maps it into kernel space, and then run 
> it as needed.  And for running it it must be executable.

so effectively vmware has it's own module loader. quite interesting ;)




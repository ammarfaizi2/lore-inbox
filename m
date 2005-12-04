Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVLDMcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVLDMcj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 07:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLDMcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 07:32:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:977 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750733AbVLDMci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 07:32:38 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051204121209.GC15577@merlin.emma.line.org>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <1133630556.22170.26.camel@laptopd505.fenrus.org>
	 <20051203230520.GJ25722@merlin.emma.line.org>
	 <43923DD9.8020301@wolfmountaingroup.com>
	 <20051204121209.GC15577@merlin.emma.line.org>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 13:32:35 +0100
Message-Id: <1133699555.5188.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 13:12 +0100, Matthias Andree wrote:
> On Sat, 03 Dec 2005, Jeff V. Merkey wrote:
> 
> > These folks have nothing new to innovate here. The memory manager and VM 
> > gets revamped every other release. Exports get broken, binary only 
> > module compatibility busted every rev of the kernel. I spend weeks on 
> 
> Who cares for binary modules?
> 
> It hurts however if external OSS modules are broken.

then those modules should be submitted realistically. That's just best
for everyone involved. Which modules in particular do you mean btw?

It's rare even in the 2.6 tree to mass-break well written drivers. Just
because it's a lot of work to fix all in kernel drivers up. But a fully
stable API is also not good. My guess is that the drivers that break
most are the ones using the not-right APIs (eg internals and such). 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVK3H5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVK3H5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 02:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVK3H5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 02:57:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11686 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751116AbVK3H5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 02:57:11 -0500
Subject: Re: [PATCH 0/9] x86-64 put current in r10
From: Arjan van de Ven <arjan@infradead.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <438D4905.9F023405@users.sourceforge.net>
References: <20051130042118.GA19112@kvack.org>
	 <438D4905.9F023405@users.sourceforge.net>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 08:56:56 +0100
Message-Id: <1133337416.2825.18.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-30 at 08:39 +0200, Jari Ruusu wrote:
> Benjamin LaHaise wrote:
> > The following emails contain the patches to convert x86-64 to store current
> > in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).
> [snip]
> > No benchmarks that I am aware of show regressions with this change.
> 
> Ben,
> Your patch breaks all out-of-tree amd64 assembler code used in kernel. 

so what?



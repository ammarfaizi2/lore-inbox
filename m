Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVK3Nc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVK3Nc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVK3Nc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:32:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9925 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751219AbVK3Nc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:32:57 -0500
Subject: Re: [PATCH 0/9] x86-64 put current in r10
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051130130216.GL19515@wotan.suse.de>
References: <20051130042118.GA19112@kvack.org>
	 <20051130130216.GL19515@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 14:32:51 +0100
Message-Id: <1133357572.2825.35.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-30 at 14:02 +0100, Andi Kleen wrote:
> On Tue, Nov 29, 2005 at 11:21:18PM -0500, Benjamin LaHaise wrote:
> > Hello Andi,
> > 
> > The following emails contain the patches to convert x86-64 to store current 
> > in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).  This 
> > provides a significant amount of code savings (~43KB) over the current 
> > use of the per cpu data area.  I also tested using r15, but that generated 
> > code that was larger than that generated with r10.  This code seems to be 
> > working well for me now (it stands up to 32 and 64 bit processes and ptrace 
> > users) and would be a good candidate for further exposure.
> 
> Looks good thanks. It will need longer testing though.

is it -mm ready?



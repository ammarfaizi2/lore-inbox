Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWBRNKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWBRNKL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWBRNKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:10:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49886 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751244AbWBRNKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:10:09 -0500
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting
	both incoming and outgoing packets
From: Arjan van de Ven <arjan@infradead.org>
To: edwin@gurde.com
Cc: Christoph Hellwig <hch@infradead.org>, netfilter-devel@lists.netfilter.org,
       fireflier-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       martinmaurer@gmx.at
In-Reply-To: <200602181447.31592.edwin@gurde.com>
References: <200602181410.59757.edwin.torok@level7.ro>
	 <200602181432.14483.edwin@gurde.com> <20060218123720.GA1811@infradead.org>
	 <200602181447.31592.edwin@gurde.com>
Content-Type: text/plain
Date: Sat, 18 Feb 2006 14:10:02 +0100
Message-Id: <1140268203.4698.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  As a last resort, I'll try to maintain this as separate patch to be 
> applied to the kernel, but that is something I'd really try to avoid, 
> because:

the problem is this: The export is going away for a reason and not "just
because". And that reason is that the implementation is going to be
radically redone such that this isn't possible anymore. At all.
No amount of patching can fix that ;)



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbULBShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbULBShz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbULBSho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:37:44 -0500
Received: from [213.146.154.40] ([213.146.154.40]:48028 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261713AbULBSgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:36:53 -0500
Date: Thu, 2 Dec 2004 18:36:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Grant Grundler <iod00d@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <20041202183629.GB32283@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Grant Grundler <iod00d@hp.com>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
	clameter@sgi.com, hugh@veritas.com, benh@kernel.crashing.org,
	nickpiggin@yahoo.com.au, linux-mm@kvack.org,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org> <20041202182716.GE25359@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202182716.GE25359@esmail.cup.hp.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 10:27:16AM -0800, Grant Grundler wrote:
> Also need to think about how well any scheme align's with what distro's
> need to support releases. Like the "Adopt-a-Highway" program in
> California to pickup trash along highways, I'm wondering if distros
> would be willing/interested in adopting a particular release
> and maintain it in bk.  e.g. SuSE clearly has interest in some sort
> of 2.6.5.n series for SLES9. ditto for RHEL4 (but for 2.6.9.n).

Unfortunately the SLES9 kernels don't really look anything like 2.6.5
except from the version number.  There's far too much trash from Business
Partners in there.


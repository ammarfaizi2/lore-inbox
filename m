Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268794AbUHLVBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbUHLVBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUHLVBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:01:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:47573 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268787AbUHLVBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:01:03 -0400
Subject: Re: [PATCH] Remove whitespace from ALI15x3 IDE driver name
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812170400.A2448@infradead.org>
References: <1092336877.7433.1.camel@localhost>
	 <20040812170400.A2448@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092340343.22362.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 20:55:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 17:04, Christoph Hellwig wrote:
> On Thu, Aug 12, 2004 at 06:54:38PM +0000, Pekka Enberg wrote:
> > This patch removes whitespace from ALI15x3 IDE driver name that appears in the
> > sysfs directory. It is against 2.6.7.
> 
> You jnow that this breaks every tool that knew of the names so far?  E.g.
> Debian mkinitrd (now has a patch to deal with both the whitespace and
> non-whitespace variants) and probably quite a few installers out there.

Greg okayed a pile of other related changes including some that were not
just white space to _ but changed the actual string. So you may want to
take it up with Greg rather than Pekka who is just filling in one that
was missed


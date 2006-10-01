Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWJAU2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWJAU2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWJAU2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:28:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43756 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932323AbWJAU2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:28:46 -0400
Subject: Re: [PATCH] ISDN: mark as 32-bit only
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061001152116.GA4684@havoc.gtf.org>
References: <20061001152116.GA4684@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 01 Oct 2006 21:53:23 +0100
Message-Id: <1159736003.13029.185.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-01 am 11:21 -0400, ysgrifennodd Jeff Garzik:
> Tons of ISDN drivers cast pointers to/from 32-bit values, which just
> won't work on 64-bit.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

NAK

I've actually been spending some time reviewing these and the warnings
are for stupid things but not real 64/32 problems. I've got some diffs
that clean it up just by tidying up casts etc if anyone actually still
cares about the old ISDN code.

Alan


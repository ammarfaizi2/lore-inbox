Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbUKTQ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUKTQ0d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUKTQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:26:32 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:48392 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261618AbUKTQ02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:26:28 -0500
Date: Sat, 20 Nov 2004 16:26:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
Message-ID: <20041120162622.GA19099@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mark A. Greer" <mgreer@mvista.com>, akpm <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
References: <419E6900.5070001@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419E6900.5070001@mvista.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just looking through this and you should share some more code with mips,
e.g. the mavell register layout should move from asm-mips/marvell.h and
your file to linux/marvell.h or something, especially as another ppc
plattform (pegasosII) needs it aswell.  

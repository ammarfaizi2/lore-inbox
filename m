Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbVLAIgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbVLAIgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbVLAIgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:36:51 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:25289 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751654AbVLAIgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:36:51 -0500
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051130190224.GE1053@flint.arm.linux.org.uk>
References: <cda58cb80511300821y72f3354av@mail.gmail.com>
	 <20051130162327.GC1053@flint.arm.linux.org.uk>
	 <cda58cb80511300845j18c81ce6p@mail.gmail.com>
	 <20051130165546.GD1053@flint.arm.linux.org.uk>
	 <1133374482.4117.91.camel@baythorne.infradead.org>
	 <20051130190224.GE1053@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 08:36:39 +0000
Message-Id: <1133426199.4117.179.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 19:02 +0000, Russell King wrote:
> We agree to disagree.  For example, in all probability, ARM will never
> see a TPM chip, yet it's offered for selection.  Given that, does it
> really make sense to offer it for ARM?

You speak of _probability_. Yes, it makes sense to offer it as an
_option_ for ARM. It just doesn't make sense to put it in the defconfig
for any of the existing platforms.

Nobody expects 'allyesconfig' to be something you'd actually want to
_use_.

-- 
dwmw2



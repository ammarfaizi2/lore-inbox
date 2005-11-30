Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbVK3SO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVK3SO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 13:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVK3SO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 13:14:57 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:52703 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751488AbVK3SO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 13:14:56 -0500
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051130165546.GD1053@flint.arm.linux.org.uk>
References: <cda58cb80511300821y72f3354av@mail.gmail.com>
	 <20051130162327.GC1053@flint.arm.linux.org.uk>
	 <cda58cb80511300845j18c81ce6p@mail.gmail.com>
	 <20051130165546.GD1053@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 18:14:42 +0000
Message-Id: <1133374482.4117.91.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 16:55 +0000, Russell King wrote:
> So until someone says "I want to use this on such and such arch" I
> think it's better to keep it dependent on those we know are likely
> to support it.

I disagree; unless there's a reason why it _shouldn't_ work on a given
architecture, it should be possible to enable it there.

I believe I've seen FR-V boards with dm9000 too.

-- 
dwmw2



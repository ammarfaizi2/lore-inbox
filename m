Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTJGI2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 04:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTJGI2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 04:28:16 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:51597 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261889AbTJGI2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 04:28:15 -0400
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
From: David Woodhouse <dwmw2@infradead.org>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E1A6a6A-0000qT-00@neptune.local>
References: <Dnwo.1ew.15@gated-at.bofh.it> <DnPL.3XB.11@gated-at.bofh.it>
	 <DsvX.3yN.1@gated-at.bofh.it>  <E1A6a6A-0000qT-00@neptune.local>
Content-Type: text/plain
Message-Id: <1065515290.22491.253.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 07 Oct 2003 09:28:11 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-06 at 20:28 +0200, Pascal Schmidt wrote:
> Now, if the driver has an internal abstraction layer that seperates the
> kernel side of things from the real work the driver does, I would agree
> that only the abstraction layer is a derived work and has to be GPL'd,
> not the rest of the driver.

> Most drivers don't work that way because of the additional 
> overhead.

And because making such distinction is pointless, since the GPL'd
wrapper and the core driver would not be distributed 'as separate works'
but rather 'as part of a whole which is a work based on the Program',
where the Program in this case is the GPL'd wrapper part. 

Hence under the terms of the final paragraph of section 2 of the GPL,
the code of the driver would also have to be released under the same
terms.

-- 
dwmw2


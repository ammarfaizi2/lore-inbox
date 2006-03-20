Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWCTTdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWCTTdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWCTTdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:33:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751281AbWCTTdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:33:17 -0500
Date: Mon, 20 Mar 2006 11:33:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Jeff Garzik <jeff@garzik.org>, joe.korty@ccur.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
In-Reply-To: <Pine.LNX.4.61.0603202022590.3457@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0603201132070.3622@g5.osdl.org>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
 <20060320171905.GA4228@tsunami.ccur.com> <441EFCB0.6020007@garzik.org>
 <Pine.LNX.4.61.0603202022590.3457@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Mar 2006, Jan Engelhardt wrote:
> >
> > strace should be using sanitized versions of the kernel headers, not directly
> > including them verbatim...
> >
> Now, would not it be good for everyone if the in-kernel headers get
> every bit of sanitation?

Yes, we should strive for fairly sanitized headers. That said, Jeff is 
also right - people really generally shouldn't use the kernel headers 
directly.

So the rigt answer is to do both: make sure that people don't use kernel 
headers, but also try to keep them reasonably clean.

		Linus

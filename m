Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUDSWCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUDSWCf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUDSWCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:02:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:15525 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261915AbUDSWCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:02:34 -0400
Subject: Re: siginfo & 32 bits compat, what is the story ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: joe.korty@ccur.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040419175503.GA4383@tsunami.ccur.com>
References: <1082360155.1677.31.camel@gaston>
	 <20040419175503.GA4383@tsunami.ccur.com>
Content-Type: text/plain
Message-Id: <1082412126.19045.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 08:02:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I believe the x86_64 method is correct.
> 
> It might be worth moving this compatibility code to a
> common place where all architectures could reference it.

Hrm... I just heard the opposite: that is, the x86_64 code allows
some cruft to communicate between 32 and 64 bits, but breaks anything
that uses more than those 3 copied fields, even between 2 32 bits
applications.

I'm lost, I don't know in which way to fix ppc64 at this point...

Ben.



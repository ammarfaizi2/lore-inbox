Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbUB1Bhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263242AbUB1Bhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:37:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:12476 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263241AbUB1Bhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:37:53 -0500
Subject: Re: [PATCH] Fix VT mode change vs. fbcon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402280059590.2216-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402280059590.2216-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077931714.22954.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 12:28:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How about calling resize_screen in vt.c instead in this function. This way 
> fbcon could reset the hardware state :-) 

Because I don't want to change the semantics in VT too much, the whole
VT code is rather fragile and I want to avoid beeing invasive at this
point and trigger all sort of funny side effects.

Ben.



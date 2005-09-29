Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVI2PW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVI2PW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVI2PW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:22:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932198AbVI2PWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:22:25 -0400
Date: Thu, 29 Sep 2005 08:22:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.13-mm2
In-Reply-To: <200509282205.49316.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.58.0509290821130.3308@g5.osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509182349.17632.daniel.ritz@gmx.ch>
 <200509231852.15950.rjw@sisk.pl> <200509282205.49316.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Sep 2005, Daniel Ritz wrote:
> 
> cc:ing linus since he seems to have a strong opinion about that free_irq-in-suspend
> thing...not doing it for USB fixes the problem for both cases: APM suspend and ACPI
> suspend...

Trivial decision: if not freeing the irq fixes the problem, then please 
send a tested patch that does just that. It's what we used to do anyway,

		Linus

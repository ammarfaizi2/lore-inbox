Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTJIR3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTJIR3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:29:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:37541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262352AbTJIR3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:29:46 -0400
Date: Thu, 9 Oct 2003 10:29:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <3F858EF8.5080105@pobox.com>
Message-ID: <Pine.LNX.4.44.0310091029070.22114-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003, Jeff Garzik wrote:
> 
> If you can't stop the NIC hardware from generating interrupts, that's a 
> driver bug.

No it's not.

Think shared interrupts here.

		Linus


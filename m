Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUDLRUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 13:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUDLRUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 13:20:32 -0400
Received: from burp.tkv.asdf.org ([212.16.99.49]:38057 "EHLO burp.tkv.asdf.org")
	by vger.kernel.org with ESMTP id S262983AbUDLRUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 13:20:32 -0400
Date: Mon, 12 Apr 2004 20:20:30 +0300
Message-Id: <200404121720.i3CHKU4w029530@burp.tkv.asdf.org>
From: Markku Savela <msa@burp.tkv.asdf.org>
To: linux-kernel@vger.kernel.org
In-reply-to: <200404121311.i3CDBexA027123@burp.tkv.asdf.org> (message from
	Markku Savela on Mon, 12 Apr 2004 16:11:40 +0300)
Subject: Re: aha152x0: irq 9 possibly wrong.  Please verify.
References: <200404121311.i3CDBexA027123@burp.tkv.asdf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Whatever IRQ I try (9, 10, 11 or 12), I always get the error in
> subject. Any ideas what I should try/do?

Problem solved, thanks to "Juergen E. Fischer"

> Have you tried to mark one interrupt between 9-12 as "Legacy ISA",
> configure to that and pass that on to the driver.

That was the key! After changing IRQ 10 to "Legacy ISA" in BIOS setup,
and configuring the card to use it, everything seems to work fine!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWJDG1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWJDG1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWJDG1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:27:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55696
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030319AbWJDG1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:27:44 -0400
Date: Tue, 03 Oct 2006 23:27:48 -0700 (PDT)
Message-Id: <20061003.232748.111208658.davem@davemloft.net>
To: jeff@garzik.org
Cc: deweerdt@free.fr, linux-kernel@vger.kernel.org, arjan@infradead.org,
       matthew@wil.cx, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       rdunlap@xenotime.net, gregkh@suse.de
Subject: Re: [RFC PATCH] move tg3 to pci_request_irq
From: David Miller <davem@davemloft.net>
In-Reply-To: <452348D7.7020205@garzik.org>
References: <4522E637.9090103@garzik.org>
	<20061003224146.GK2785@slug>
	<452348D7.7020205@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Wed, 04 Oct 2006 01:38:31 -0400

> As for why the flag may be missing -- PCI MSI interrupts are never 
> shared.  However, it won't _hurt_ anything to set the flag needlessly, 
> AFAIK.

That's right.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWJCWg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWJCWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWJCWg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:36:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:902 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030486AbWJCWg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:36:26 -0400
Message-ID: <4522E5E8.7010405@garzik.org>
Date: Tue, 03 Oct 2006 18:36:24 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] move e1000 to pci_request_irq
References: <20061003220732.GE2785@slug> <20061003222345.GI2785@slug>
In-Reply-To: <20061003222345.GI2785@slug>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> +	else if (pci_request_irq(adapter->pdev, &e1000_test_intr, IRQF_SHARED,
> +		 		 netdev->name)) {

doesn't need IRQF_SHARED flag anymore


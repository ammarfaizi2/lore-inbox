Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967007AbWLDUqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967007AbWLDUqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967016AbWLDUqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:46:35 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37649 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967007AbWLDUqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:46:34 -0500
Message-ID: <45748928.908@garzik.org>
Date: Mon, 04 Dec 2006 15:46:32 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_ali: small fixes
References: <20061204163605.51dc4353@localhost.localdomain>
In-Reply-To: <20061204163605.51dc4353@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Switch to pci_get_bus_and_slot because some x86 systems seem to be
> handing us a device with dev->bus = NULL. Also don't apply the isa fixup
> to revision C6 and later of the chip. 
> 
> Really we need to work out wtf is handing us pdev->bus = NULL, but firstly
> and more importantly we need the drivers working.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied



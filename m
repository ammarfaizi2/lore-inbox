Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWIZRfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWIZRfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWIZRfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:35:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53641 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932167AbWIZRfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:35:04 -0400
Message-ID: <451964C5.9090909@pobox.com>
Date: Tue, 26 Sep 2006 13:35:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: refuse to register IRQless ports
References: <1159288532.11049.250.camel@localhost.localdomain>
In-Reply-To: <1159288532.11049.250.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> We don't currently support pure polled operation so when we meet a BIOS
> which forgot to assign an IRQ to a PCI device it all goes a little pear
> shaped. Trap this case properly.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, but please stop adding trailing whitespace



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWJFQmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWJFQmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWJFQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:42:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:23458 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161003AbWJFQmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:42:21 -0400
Message-ID: <4526876A.5090103@garzik.org>
Date: Fri, 06 Oct 2006 12:42:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] Rename pdc_init
References: <11601511393703-git-send-email-matthew@wil.cx>
In-Reply-To: <11601511393703-git-send-email-matthew@wil.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> parisc uses pdc_init() for different purposes, so call it pdc202xx_init
> instead.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

I don't mind the patch (you should have CC'd me and linux-ide though), 
but where is parisc's pdc_init actually used, and why is it global?

	Jeff




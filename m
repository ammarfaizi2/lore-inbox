Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbTHaNNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTHaNNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:13:10 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43705 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261934AbTHaNNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:13:09 -0400
Subject: Re: [BUG] hda:end_request: I/O error, dev 03:00 (hda), sector 0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Chua <jeff89@silk.corp.fedex.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.42.0308311221430.17575-100000@silk.corp.fedex.com>
References: <Pine.LNX.4.42.0308311221430.17575-100000@silk.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062335526.31332.41.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 14:12:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 05:24, Jeff Chua wrote:
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Partition check:
>  hda:end_request: I/O error, dev 03:00 (hda), sector 0
> end_request: I/O error, dev 03:00 (hda), sector 2
> end_request: I/O error, dev 03:00 (hda), sector 4

You don't have IDE hard disk support included so the kernel finds
it has no way to read the partition table.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272979AbTHMNFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273288AbTHMNFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:05:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31365 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272979AbTHMNFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:05:03 -0400
Message-ID: <3F3A3773.5070108@pobox.com>
Date: Wed, 13 Aug 2003 09:04:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Realtek network card
References: <20030813133059.616f0faa.skraw@ithnet.com>
In-Reply-To: <20030813133059.616f0faa.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> Hello all,
> 
> does anybody know how to make the below work (neiter 2.2.25 nor 2.4.21 seem to recognise it):
> 
> lspci --vv:
> 
> 00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device 8131 (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 8139


The subsystem device id seems to indicate 8139, so you probably just 
need to add pci ids to 8139too.c.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWAVVDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWAVVDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWAVVDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:03:53 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:33991 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751364AbWAVVDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:03:51 -0500
Message-ID: <43D3F338.8010608@linuxtv.org>
Date: Sun, 22 Jan 2006 16:03:52 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       linux-dvb-maintainer@linuxtv.org, mchehab@brturbo.com.br
Subject: Re: [PATCH] dvb: fix printk format warning
References: <20060117211426.573066bb.rdunlap@xenotime.net>
In-Reply-To: <20060117211426.573066bb.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix printk type warning:
> drivers/media/dvb/b2c2/flexcop-pci.c:164: warning: format '%08x' expects type 'unsigned int', but argument 4 has type 'dma_addr_t'
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

I've applied this to our cvs tree.  Thanks, Randy.

Mauro, please apply this to v4l-dvb.git with your next push.

Regards,

Michael

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWAQNib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWAQNib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWAQNib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:38:31 -0500
Received: from mail.dvmed.net ([216.237.124.58]:23211 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932480AbWAQNia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:38:30 -0500
Message-ID: <43CCF351.2050004@pobox.com>
Date: Tue, 17 Jan 2006 08:38:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/arcnet/: possible cleanups
References: <20060114021022.GE29663@stusta.de>
In-Reply-To: <20060114021022.GE29663@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Adrian Bunk wrote: > This patch contains the following
	possible cleanups: > - make needlessly global code static > - arcnet.c:
	remove the unneeded EXPORT_SYMBOL(arc_proto_null) > - arcnet.c: remove
	the unneeded EXPORT_SYMBOL(arcnet_dump_packet) > > To make Jeff happy,
	arcnet.c still prints > arcnet: v3.93 BETA 2000/04/29 - by Avery
	Pennarun et al. > > > Signed-off-by: Adrian Bunk <bunk@stusta.de> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - arcnet.c: remove the unneeded EXPORT_SYMBOL(arc_proto_null)
> - arcnet.c: remove the unneeded EXPORT_SYMBOL(arcnet_dump_packet)
> 
> To make Jeff happy, arcnet.c still prints
>   arcnet: v3.93 BETA 2000/04/29 - by Avery Pennarun et al.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied



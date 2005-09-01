Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVIAIMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVIAIMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVIAIMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:12:45 -0400
Received: from smtpa3.netcabo.pt ([212.113.174.18]:16535 "EHLO
	exch01smtp02.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S965081AbVIAIMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:12:45 -0400
Message-ID: <4316B82B.2060306@rncbc.org>
Date: Thu, 01 Sep 2005 09:13:31 +0100
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] drivers/ide/pci/alim15x3.c SMP fix
References: <20050901072430.GA6213@elte.hu>
In-Reply-To: <20050901072430.GA6213@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Sep 2005 08:12:32.0953 (UTC) FILETIME=[E7728290:01C5AECC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> is this the right way to fix the UP assumption below?
> 
> 	Ingo
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Index: linux/drivers/ide/pci/alim15x3.c
 > [snip]

OK. The reported boot WARNING seems to be over now. Tested on the 
offended laptop (P4@2.53Ghz/UP, PCI chipset: ALi M1533) with 2.6.13-rt3, 
where the suggested patch on drivers/ide/pci/alim15x3.c seems to fix the 
burp. All seems to be working fine, still ;)

Thanks.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVIAIuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVIAIuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVIAIuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:50:11 -0400
Received: from smtpa3.netcabo.pt ([212.113.174.18]:8629 "EHLO
	exch01smtp02.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750745AbVIAIuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:50:10 -0400
Message-ID: <4316C0FB.3050004@rncbc.org>
Date: Thu, 01 Sep 2005 09:51:07 +0100
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] drivers/ide/pci/alim15x3.c SMP fix
References: <20050901072430.GA6213@elte.hu> <4316B82B.2060306@rncbc.org> <20050901081753.GA7952@elte.hu>
In-Reply-To: <20050901081753.GA7952@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Sep 2005 08:50:09.0153 (UTC) FILETIME=[283F4F10:01C5AED2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>Rui Nuno Capela wrote:
>>OK. The reported boot WARNING seems to be over now. Tested on the 
>>offended laptop (P4@2.53Ghz/UP, PCI chipset: ALi M1533) with 
>>2.6.13-rt3, where the suggested patch on drivers/ide/pci/alim15x3.c 
>>seems to fix the burp. All seems to be working fine, still ;)
>  
> just to make sure the original point gets across: the warning is only in 
> the -rt tree, and it pinpoints potential SMP bugs. Does your box do 
> hyperthreading?

Nope. The P4@2.53Ghz is from pre-HT age, and the kernel is being built 
for UP.

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



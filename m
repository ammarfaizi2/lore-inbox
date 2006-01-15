Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWAOTSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWAOTSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAOTSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:18:34 -0500
Received: from mail4.zigzag.pl ([217.11.136.106]:7853 "HELO mail4.zigzag.pl")
	by vger.kernel.org with SMTP id S1750810AbWAOTSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:18:33 -0500
X-Mail-Scanner: Scanned by qSheff 1.0-r3 (http://www.enderunix.org/qsheff/)
Message-ID: <43CA9FFB.8090305@mieszczak.com.pl>
Date: Sun, 15 Jan 2006 20:18:19 +0100
From: Miroslaw Mieszczak <mirek@mieszczak.com.pl>
User-Agent: Thunderbird 1.5 (X11/20060114)
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, "Seth, Rohit" <rohit.seth@intel.com>,
       ajk <a@oo.ms>
Subject: Re: [2.6] Problem with PDC20265 on system with I865 chipset and PIV
 HT
References: <43C6DA9D.4060300@mieszczak.com.pl> <20060113001618.66821fcb.akpm@osdl.org> <Pine.LNX.4.64.0601130910420.1579@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0601130910420.1579@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Without pagetable corruption no they shouldn't fault, interestingly this 
> looks like;
>
> http://bugzilla.kernel.org/show_bug.cgi?id=5565
>
> Albeit with a pdc20262. Miroslaw, are there any other similarities in 
> hardware with that bugzilla entry?
>
> Thanks,
> 	Zwane
>
>   
Hmm. Yes it looks to be similar. Right now on my equipment the only 
workaround for it is use of kernel parameters ide[23]=serialize. I use 
it since about 1 year and this works fine.
Maybe Andrew can check same setting on his equipment?

Regards

Mirek


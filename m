Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKZVwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKZVwD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 16:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKZVwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 16:52:03 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:61858 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750757AbVKZVwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 16:52:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=M//1GNOcGf0VZlRqUVfhjGfdw8a3hn2vIblXjG+U8d+pNmrzC6X04QSjTsNB5FOjRcefW86P0k8lDnWEc2Uv/cP2xGb5Lhl98c8PjbypsHlgyjnxPKJdylH8YhadNpDeHa2Xjjw6laXotUH3rMV53AvVtnFTMHLfgPLF60AUCgM=
Message-ID: <4388D8E1.2040806@gmail.com>
Date: Sun, 27 Nov 2005 05:51:29 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: "Calin A. Culianu" <calin@ajvar.org>, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org, linux-nvidia@lists.surfsouth.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] nvidiafb support for 6600 and 6200
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <4387FFFD.2000109@gmail.com>
In-Reply-To: <4387FFFD.2000109@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Calin A. Culianu wrote:
>> Hi,
>>
>> This patch can be applied against 2.6.15-rc1 to add support to the
>> nvidiafb driver for a few obscure (yet on-the-market) nvidia
>> boards/chipsets, including various versions of the Geforce 6600 and 6200.
>>
>> This patch has been tested and allows the above-mentioned boards to get
>> framebuffer console support.
>>
> 
> Is this a pci-e card?  With a pci-e card, the actual chipset type is located
> in one of the registers (instead of deriving it from the pci device id) and
> will resolve into one of the supported architectures, usually an NV_ARCH_40.
> 
> Can you try this patch instead? And send me your dmesg whether it works or
> not.

Forgot to mention that you still have to add your device to nvidiafb_pci_tbl
after applying this patch.

Tony

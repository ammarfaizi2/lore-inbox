Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVA0XJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVA0XJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVA0XFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:05:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:33177 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261277AbVA0XEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:04:43 -0500
Message-ID: <41F97185.6030905@osdl.org>
Date: Thu, 27 Jan 2005 14:56:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PNP and bus association
References: <41F95A42.40001@drzeus.cx>
In-Reply-To: <41F95A42.40001@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> I recently tried out adding PNP support to my driver to remove the 
> hassle of finding the correct parameters for it. This, however, causes 
> it to show up under the pnp bus, where as it previously was located 
> under the platform bus.
> 
> Is the idea that PNP devices should only reside on the PNP bus or is 
> there some magic available to get the device to appear on several buses? 
> It's a bit of a hassle to search in two different places in sysfs 
> depending on if PNP is used or not.
> 
> Also, the PNP bus doesn't really say that much about where the device is 
> physically connected. The other bus types usually give a hint about this.

Not to take away from your question, but:
Is there "the PNP bus"?  I've seen an ISA bus that (sort of)
supports PNP, PCI PNP, NuBus PNP, USB PNP, IEEE 1394 PNP, etc.

-- 
~Randy

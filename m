Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVBZUUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVBZUUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 15:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVBZUUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 15:20:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36302 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261272AbVBZUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 15:20:02 -0500
Message-ID: <4220D9DE.10904@pobox.com>
Date: Sat, 26 Feb 2005 15:19:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
CC: Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com> <421D3D33.9060707@pobox.com> <20050226193255.GA6256@ime.usp.br>
In-Reply-To: <20050226193255.GA6256@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> On Feb 23 2005, Jeff Garzik wrote:
> 
>>Does this patch do anything useful?
>>	Jeff
> 
> (...)
> 
> The patch you posted seems to only affect people using SATA, right?
> 
> BTW, just for clarity I'm seeing the message in a PATA environment (on
> i386) and Brian is seeing his problem with a SATA device on ppc.

"irq XX: nobody cared" is a screaming interrupt situation, which could 
have 1001 causes.

Normally it's something that "pci=biosirq" or "acpi=off" will fix, but 
on occasion the driver itself is what needs fixing.

	Jeff




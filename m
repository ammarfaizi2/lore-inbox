Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269768AbUJGJbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269768AbUJGJbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269766AbUJGJbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:31:37 -0400
Received: from webapps.arcom.com ([194.200.159.168]:30729 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S269768AbUJGJae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:30:34 -0400
Message-ID: <41650CB9.80608@arcom.com>
Date: Thu, 07 Oct 2004 10:30:33 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6][2/54] arch/i386/pci/acpi.c Use for_each_pci_dev macro
References: <3740000.1097094228@w-hlinder.beaverton.ibm.com>
In-Reply-To: <3740000.1097094228@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2004 09:35:16.0203 (UTC) FILETIME=[F3DE9BB0:01C4AC50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> 
> +		for_each_pci_dev(dev);

That semicolon doesn't look right.

>  			acpi_pci_irq_enable(dev);

David Vrabel

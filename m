Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVDATB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVDATB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVDATB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:01:56 -0500
Received: from smtp07.web.de ([217.72.192.225]:7603 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S262840AbVDATBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:01:54 -0500
Message-ID: <424D9A9C.2070705@web.de>
Date: Fri, 01 Apr 2005 21:01:48 +0200
From: Michael Thonke <tk-shockwave@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050323)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI-Express not working/unuseable on Intel 925XE Chipset since
 2.6.12-rc1[mm1-4]
References: <424D44F0.6090707@web.de> <424D5E2E.8040207@pin.if.uz.zgora.pl> <424D71DE.5060703@web.de> <424D91B5.50404@pin.if.uz.zgora.pl>
In-Reply-To: <424D91B5.50404@pin.if.uz.zgora.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0513-2, 01.04.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jacek,

I finially got it working :-) my PCI-Express devices working now...
I grabbed the last bk-snapshot from kernel.org 2.6.12-rc1-bk3 and et volia
everything except the Marvell Yokon PCI-E device working.
I hope Andrew will look into the mm-line to find the bug?

Greets and
Best regards

|Jacek Luczak schrieb:

> hello Michael :)
>
> This message:
>
> ACPI: No ACPI bus support for 00:00
>
> means that acpi_get_bus_type() is unable to determinate
> bus type! Mayby someone forgot about PCI-E?
>
> Regards
>     Jacek



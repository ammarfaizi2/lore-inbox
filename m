Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVDASWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVDASWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVDASWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:22:38 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:5063 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S262832AbVDASWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:22:35 -0500
Message-ID: <424D91B5.50404@pin.if.uz.zgora.pl>
Date: Fri, 01 Apr 2005 20:23:49 +0200
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Michael Thonke <tk-shockwave@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-Express not working/unuseable on Intel 925XE Chipset since
 2.6.12-rc1[mm1-4]
References: <424D44F0.6090707@web.de> <424D5E2E.8040207@pin.if.uz.zgora.pl> <424D71DE.5060703@web.de>
In-Reply-To: <424D71DE.5060703@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello Michael :)

This message:

ACPI: No ACPI bus support for 00:00

means that acpi_get_bus_type() is unable to determinate
bus type! Mayby someone forgot about PCI-E?

Regards
	Jacek

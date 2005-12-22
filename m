Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbVLVUCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbVLVUCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbVLVUB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:01:59 -0500
Received: from mail.dvmed.net ([216.237.124.58]:19643 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965177AbVLVUB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:01:58 -0500
Message-ID: <43AB0632.5040903@pobox.com>
Date: Thu, 22 Dec 2005 15:01:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Conio sandiago <coniodiago@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ethtool integration
References: <993d182d0512220516m5b8c0448k5cdc564b435c621a@mail.gmail.com>
In-Reply-To: <993d182d0512220516m5b8c0448k5cdc564b435c621a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Conio sandiago wrote: > Hi all > I need some help
	regarding handling ethtool. > i have developed a ethernet driver for my
	linux kernel. > i want to run the ethtool on the kernel. > Now i want
	to know which command do i have to implement in my driver ? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conio sandiago wrote:
> Hi all
> I need some help regarding handling ethtool.
> i have developed a ethernet driver for my linux kernel.
>  i want to run the ethtool on the kernel.
> Now i want to know which command do i have to implement in my driver ?

Take a look at tons of existing ethernet drivers in the Linux kernel, 
for examples.

You need to implement one or more functions of struct ethtool_ops.

	Jeff




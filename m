Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVANVoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVANVoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVANVnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:43:05 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:30109 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262124AbVANVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:39:57 -0500
Message-ID: <41E83C2D.6070101@nero.com>
Date: Fri, 14 Jan 2005 22:39:57 +0100
From: Gian-Carlo Pascutto <gpascutto@nero.com>
Organization: Ahead Software AG
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ServerWorks CSB6 DMA problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

is anyone aware of the status of ServerWorks CSB6's chipset DMA support?

On a machine with a RHEL3 kernel (2.4.21-27.0.1.EL), the kernel seems to 
enable UDMA33 on the first connected disk (Seagate 7200.7) but uses PIO 
mode on the second (Maxtor 6Y080P0).

I found out this is for good reasons because after enabling UDMA100 on 
both disks, via hdparm, filesystem corruption quickly resulted.

Googling turns up a lot of talk about buggy CSB4 chipsets, but nothing 
about the CSB6, actually several posts claiming it should work ok. The 
above experience and the kernel's selection suggest that's not the whole 
story though.

Basically, I'm curious if there's any *safe* way to get some more 
performance out of this configuration on Linux, or if I'm SOL. I mean, 
the Maxtor in PIO mode works at about 2Mb/s... :-/

-- 
GCP

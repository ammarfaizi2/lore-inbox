Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWH3DnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWH3DnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 23:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWH3DnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 23:43:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:16565 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751297AbWH3DnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 23:43:08 -0400
Message-ID: <44F50940.1010204@cn.ibm.com>
Date: Wed, 30 Aug 2006 11:42:56 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-mm@kvack.org, havelblue@us.ibm.com
Subject: Swap file or device can't be recognized by kernel built with 64K
 pages.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem description:
swap file or device can't be recognized by kernel built with 64K pages.

Hardware Environment:
    Machine type (p650, x235, SF2, etc.): B70+
    Cpu type (Power4, Power5, IA-64, etc.): POWER5+
Software Environment:
    OS : SLES10 GMC
    Kernel: 2.6.18-rc5
Additional info:

tc1:~ # uname -r
2.6.18-rc5-ppc64

tc1:~ # zcat /proc/config.gz | grep 64K
CONFIG_PPC_64K_PAGES=y

tc1:~ # mkswap ./swap.file
Assuming pages of size 65536 (not 4096)
Setting up swapspace version 0, size = 4294901 kB

tc1:~ # swapon ./swap.file
swapon: ./swap.file: Invalid argument



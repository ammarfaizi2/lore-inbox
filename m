Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVALJNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVALJNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 04:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVALJNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 04:13:49 -0500
Received: from info.elf.stuba.sk ([147.175.111.14]:48142 "EHLO
	info.elf.stuba.sk") by vger.kernel.org with ESMTP id S261303AbVALJNs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 04:13:48 -0500
Message-ID: <41E4EB04.50705@kasr.elf.stuba.sk>
Date: Wed, 12 Jan 2005 10:16:52 +0100
From: peto <fodrek@kasr.elf.stuba.sk>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATX Power Off(down) without APM. Is it possible?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned: by AntiVirus filter AVilter (msg.7Q9WKDdh@delta.elf.stuba.sk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers,

I am to use RT Linux and it used kernel patch that requires kernel.org 
version of the kernel and APM and ACPI to be switched Off. But I am to 
Power Off my ATX machine when program finiseh, so I does not used RT 
Linux, yet. Can you recommend me how to do so, and hoe to do so 
correctly,please?
adding kernel parameters viac lilo as append="apm power-off" just 
switches power form HDD, but not form the ATX board (Via Apollo KT800 
ans Athlon XP 2200 Thoroghbred). It prints just Power down and doest not 
"switch off" power. I was found in source this text but it was followed 
by call never declared funcion machine_power_down and it seems to be 
BIOS function.

Can anyone help me?


Thank  you for any help


Yours faithfully

Peter Fodrek

P.S. Slackware 9.0 is my distribution

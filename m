Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVAJNUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVAJNUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVAJNUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:20:23 -0500
Received: from smtp.raid.ru ([212.33.224.148]:26378 "EHLO smtp.raid.ru")
	by vger.kernel.org with ESMTP id S262232AbVAJNUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:20:18 -0500
Message-ID: <41E28115.4010002@permonline.ru>
Date: Mon, 10 Jan 2005 18:20:21 +0500
From: "Artem S. Tashkinov" <birdie@permonline.ru>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: 100% CPU load on nforce2/3 motherboards with kernels >= 2.6.8
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Bartlomiej Zolnierkiewicz!

I've got a severe problem with linux >= 2.6.9 kernels on my PC: any 
read/write HDD IO operations consume 100% of CPU. Kernel is compiled 
with nforce IDE support. Kernel is vanilla from kernel.org. No 
proprietary drivers are installed. My chipset is NForce3 250, CPU is 
Sempron 3100. My MB is GigaByte K8NS Pro.

My friend (who has an nforce2 based motherboard Asus A7N8X-X) has the 
same problem with >= 2.6.9 kernels. 2.6.7 at the same time works fine 
for him.

His and mine kernels say that the HDD is in UDMA5 mode. I tried 
switching off ACPI/IO APIC and even Plug'n'Play code with no success. 
Kernel 2.4.28 works perfectly

With respect, Artem

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVD3UUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVD3UUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVD3UTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:19:30 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:31976 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261414AbVD3UQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:16:51 -0400
Message-ID: <4273E7B1.6020500@myrealbox.com>
Date: Sat, 30 Apr 2005 13:16:49 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [x86_64] how worried should I be about MCEs?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every now and then, after rebooting, the kernel notices some MCEs. 
Should I be worried about this?

(mcelog attached)

Thanks,
Andy


MCE 0
CPU 0 0 data cache from boot or resume
ADDR 480b0c84df48
   Data cache ECC error (syndrome c8)
        bit46 = corrected ecc error
        bit57 = processor context corrupt
        bit61 = error uncorrected
        bit62 = error overflow (multiple errors)
STATUS f66440000000438d MCGSTATUS 0
MCE 1
CPU 0 1 instruction cache from boot or resume
ADDR 75e2bb87ec57f8e0
   Instruction cache ECC error
        bit32 = err cpu0
        bit33 = err cpu1
        bit35 = res3
        bit43 = res11
        bit45 = uncorrected ecc error
        bit46 = corrected ecc error
        bit55 = res23
        bit56 = res24
        bit57 = processor context corrupt
        bit59 = misc error valid
        bit61 = error uncorrected
        bit62 = error overflow (multiple errors)
STATUS ffe4681bd0e45d81 MCGSTATUS 0
MCE 2
CPU 0 3 load/store unit from boot or resume
MISC 8005003b8005003b
        bit57 = processor context corrupt
        bit59 = misc error valid
        bit61 = error uncorrected
        bit62 = error overflow (multiple errors)
STATUS fa0000000000d0c5 MCGSTATUS 0
MCE 3
CPU 0 4 northbridge from boot or resume
ADDR 102000020
   Northbridge ECC error
   ECC syndrome = 0
        bit32 = err cpu0
        bit33 = err cpu1
        bit40 = error found by scrub
        bit45 = uncorrected ecc error
        bit57 = processor context corrupt
        bit61 = error uncorrected
STATUS b600215300001e0f MCGSTATUS 0

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbUKHIoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUKHIoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUKHIoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:44:04 -0500
Received: from solidcore.com ([66.201.45.194]:20894 "EHLO solidcore.com")
	by vger.kernel.org with ESMTP id S261789AbUKHInh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:43:37 -0500
Message-ID: <003401c4c55b$168ece50$6f52a8c0@rpm>
From: "Rajendra" <rpm@solidcore.com>
To: <linux-kernel@vger.kernel.org>
Subject: problem booting SMP kernel !
Date: Mon, 8 Nov 2004 14:20:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
   I have been trying to boot an SMP kernel (2.4.20 redhat) on my laptop
(Dell Inspiron 5160) without any success.
It has hyper-threaded processor (Pentium IV 3.0 GHz - HT). 2.6.5 kernel is
booting fine and is able to detect the
Hyperthreading and initilize it and I can see two processors in my
/proc/cpuinfo with 2.6.5 booted up.

I searched around the internet to find out if i can get some other kernel,
or if someone has succeded in getting
SMP up on these laptops. I also tried 2.4.24 and 2.4.27 from kernel.org. But
all of them seem to stop at the same place.
Here is the log for 2.4.27 kernel bootup
.
.
.
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Not responding.
Error: only one processor found.
Warning: No sibling found for CPU 0.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3056.5842 MHz.
..... host bus clock speed is 0.0000 MHz.
cpu: 0, clocks: 0, slice: 0
---------------------------- HANGS here, for
ever --------------------------------------

I can send the 2.6 kernel bootup log if required !

Somewhere on the net i read that this problem is due to buggy BIOS on these
laptops, it has some problem
with APIC's. But it boots up all well with 2.6 kernel, so i think i can make
it work with 2.4. too. I have some idea
about the linux kernel and can backport the stuff from 2.6 with some help.
To be precise, if someone can
point out the cause of the problem.

I have tried the options like "acpismp=force", "acpi=off", but the problem
seems to be beyond it.

If someone has a quick workaround to make it work please let me know.

I am sending this mail for second time .... if anyone has any pointers 
please send it over.

thanks,
-rpm




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVITQtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVITQtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbVITQtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:49:09 -0400
Received: from 82-68-65-126.dsl.in-addr.zen.co.uk ([82.68.65.126]:59782 "EHLO
	www.drunkenpirates.co.uk") by vger.kernel.org with ESMTP
	id S932664AbVITQtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:49:08 -0400
Message-ID: <002b01c5be03$4bf25840$6401a8c0@CMR>
From: "Chris Rutherford" <chris1@hackinghardware.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: pci bridge 0000:00:1c.1 compaq nc8230 laptop
Date: Tue, 20 Sep 2005 17:49:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is my first email to the lkml so kindly forgive me if I appear 
naive.

I have a compaq nc8230 laptop with a TPM which I am 'playing with'.

I have successfully compiled and patched previous kernel versions 
2.6.6 to 2.6.12 and as of patching 2.6.12 with the TPM libraries I was 
able to access the tpm using an Intel motherboard but not the Compaq 
machine.

Unfortunately the tpm libries in the 2.6.12 kernel were not combatable 
with the Compaq tpm implementation and I was not able to locate the 
TPM address or device and the kernel module could not find the TPM IC.

As of 2.6.13 the TPM code has been properly integrated with the kernel 
and I was hoping to get the TPM working on my laptop.  Although I 
could successfully get the 2.6.12, to compile and run on the nc8230, 
as of 2.6.13 I have been getting the following crash when I start the 
kernel :-

PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1

 I have seen the 00:1c.1 device problem in the lkml archive, however 
im not sure exactly what the problem is.  I thought I'd let you all 
know that something has happened to the new kernel that stops it 
working on the compaq nc8230 laptop.  I would very much like to know 
if this problem is known and if it is going to be fixed in the 2.6.14 
release.

Thanks

Chris R





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUCFNBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 08:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUCFNBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 08:01:36 -0500
Received: from vsmtp2alice.tin.it ([212.216.176.142]:32733 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S261661AbUCFNBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 08:01:34 -0500
Message-ID: <4049CCC5.9080104@tin.it>
Date: Sat, 06 Mar 2004 14:06:13 +0100
From: Maggio <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IRQ USB , freezes with ABIT KV7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all ,

I've recently switched from an MSI KT4 Ultra motherboard to an Abit KV7 
board ,and the system worked well until today that I'm attempting to 
reinstall the system .

It seems that the USB make some conflicts in IRQ , infact , if I enable 
the option "Allocate IRQ to USB" in the BIOS , I'm unable to start any 
Installation CD of any distribution , the booting simply hangup .

This doesn't happen if I've APIC and ACPI enabled , but if I use the 
PCI-BIOS mode this happens (nearly all Linux distributions start the 
system installation without APIC and ACPI ). FreeBSD and NetBSD hasn't 
this problem , and both those boot without problem and with USB enabled .

If I disable the option "Allocate IRQ to USB" in the BIOS the system 
boot up correctly .

Any ideas?

Thanks

Marcello



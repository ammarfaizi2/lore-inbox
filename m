Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269079AbUJUJLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269079AbUJUJLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUJUJHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:07:16 -0400
Received: from fmr05.intel.com ([134.134.136.6]:12676 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270345AbUJUJFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:05:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Date: Thu, 21 Oct 2004 17:04:59 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFD4@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
Thread-Index: AcS3Fxo7eXcEZqjvRkeuzpHjx/stsgANDPMQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Borislav Deianov" <borislav@users.sourceforge.net>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Oct 2004 09:05:00.0449 (UTC) FILETIME=[0B610910:01C4B74D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Wed, Oct 20, 2004 at 11:18:08AM +0800, Yu, Luming wrote:
>> 
>> I'm working on a generic hotkey driver, which will move configurable 
>> stuff to user space. 
>[snip]
>> 1. add a new hotkey:
>>  echo "0 : _SB.VGA : _SB.VGA.LCD._BCM :0x86 : 0x86" >
>> /proc/acpi/ev_config
>
>How would user space know what devices and methods to use? In the
>kernel, you can use HIDs where available, or check for specific
>objects with acpi_get_handle(). Are you going to expose these to user
>space somehow?
>
>Boris
>

Wrt hotkey, there don't have any standard or well known method to
find out which acpi device and acpi methods are for which hotkey.
But, they are working in the similar way, which is achieving hotkey 
function through acpi generic core. 

So, at the first stage , I have to rely on user or vendor to supply 
meaningful data, till we have standard auto-config method.

Thanks,
Luming


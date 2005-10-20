Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVJTTf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVJTTf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 15:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVJTTf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 15:35:28 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30994 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932502AbVJTTf1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 15:35:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4357E4E9.4@t-online.de>
References: <4357E4E9.4@t-online.de>
X-OriginalArrivalTime: 20 Oct 2005 19:35:22.0191 (UTC) FILETIME=[6941DDF0:01C5D5AD]
Content-class: urn:content-classes:message
Subject: Re: 2.6.13.4: 'find' complained about sysfs
Date: Thu, 20 Oct 2005 15:35:22 -0400
Message-ID: <Pine.LNX.4.61.0510201532200.16582@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13.4: 'find' complained about sysfs
Thread-Index: AcXVrWlJKKv4R0eES0uT894DSzTFXg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Harald Dunkel" <harald.dunkel@t-online.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Oct 2005, Harald Dunkel wrote:

> Hi folks,
>
> When I ran 'find /sys -name modalias' I got an error
> message on stderr saying
>
> find: WARNING: Hard link count is wrong for /sys/devices: this may be a
> bug in your filesystem driver.  Automatically turning on find's -noleaf
> option.  Earlier results may have failed to include directories that should
> have been searched.
>
> uname -a:
> Linux pluto 2.6.13.4 #1 Sun Oct 16 22:41:26 CEST 2005 x86_64 GNU/Linux
>
>
> Regards
>
> Harri
>

Works here, same kernel version, GNU find version 4.1.7.

Script started on Thu 20 Oct 2005 03:31:28 PM EDT
[root@chaos /]# find /sys -name "modalias"
/sys/devices/pci0000:00/0000:00:1f.5/modalias
/sys/devices/pci0000:00/0000:00:1f.3/modalias
/sys/devices/pci0000:00/0000:00:1f.2/modalias
/sys/devices/pci0000:00/0000:00:1f.1/modalias
/sys/devices/pci0000:00/0000:00:1f.0/modalias
/sys/devices/pci0000:00/0000:00:1e.0/0000:02:08.0/modalias
/sys/devices/pci0000:00/0000:00:1e.0/0000:02:07.0/modalias
/sys/devices/pci0000:00/0000:00:1e.0/0000:02:03.0/modalias
/sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.0/modalias
/sys/devices/pci0000:00/0000:00:1e.0/0000:02:00.0/modalias
/sys/devices/pci0000:00/0000:00:1e.0/modalias
/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:1d.7/modalias
/sys/devices/pci0000:00/0000:00:1d.3/usb5/5-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:1d.3/modalias
/sys/devices/pci0000:00/0000:00:1d.2/usb4/4-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:1d.2/modalias
/sys/devices/pci0000:00/0000:00:1d.1/usb3/3-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:1d.1/modalias
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-0:1.0/modalias
/sys/devices/pci0000:00/0000:00:1d.0/modalias
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/modalias
/sys/devices/pci0000:00/0000:00:01.0/modalias
/sys/devices/pci0000:00/0000:00:00.0/modalias
/sys/devices/platform/i8042/serio1/modalias
/sys/devices/platform/i8042/serio0/modalias
[root@chaos /]# exit

Script done on Thu 20 Oct 2005 03:31:56 PM EDT

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

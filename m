Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWC3SxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWC3SxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWC3SxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:53:21 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:15152 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750731AbWC3SxU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:53:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uVPRGSN/KCmbf9U3VnQLQ2prsLlZFIiiwH7TV9FJi477hb+5s5tcL3V12UJwgpIWoHZUECxwcANTqzw7xhDS2q4/TGGLOXpF50L/tbVU+O2qDrLjJWY5vi8Y4K6UD+ACnIpadVzBKmi2NtpPX6XpOBhtA4i0N6XQdbgtqK8J14c=
Message-ID: <4d8e3fd30603301053h31bf53aayed1e8c94b8cea500@mail.gmail.com>
Date: Thu, 30 Mar 2006 20:53:19 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: No automount of USB stick with latest kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
it has been a long time since the last time I used a vanilla kernel
(more then 1 year) so I cannot say when this problem came up.

paolo@Italia:~$ uname -a
Linux Italia 2.6.16-g5d4fe2c1 #7 PREEMPT Thu Mar 30 20:26:30 CEST 2006
i686 GNU/

paolo@Italia:~$ udevinfo -V
udevinfo, version 079

If I plug my usb stick I see the following in /var/log/messages:
Mar 30 20:50:44 localhost kernel: usb 1-4: new high speed USB device
using ehci_hcd and address 3
Mar 30 20:50:45 localhost kernel: usb 1-4: Product: Flash Disk
Mar 30 20:50:45 localhost kernel: usb 1-4: Manufacturer: USB
Mar 30 20:50:45 localhost kernel: usb 1-4: SerialNumber: AA0070005481932D
Mar 30 20:50:45 localhost kernel: usb 1-4: configuration #1 chosen from 1 choice
Mar 30 20:50:45 localhost kernel: scsi1 : SCSI emulation for USB Mass
Storage devices
Mar 30 20:50:50 localhost kernel:   Vendor: Imation   Model:  USB
Flash Drive  Rev: 2.00
Mar 30 20:50:50 localhost kernel:   Type:   Direct-Access             
        ANSI SCSI revision: 02

But the volume is NOT automounted, it is if I boot using a kenel from
Ubuntu Dapper.

Is udev 0.80 required for 2.6.15-xxxx ?
If so... I cannot find any reference in the documentation.

Thanks!!


--
Paolo
http://paolociarrocchi.googlepages.com

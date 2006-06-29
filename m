Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWF2PTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWF2PTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWF2PTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:19:05 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:14881 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750775AbWF2PTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:19:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hp7+1/hPGlhYhDodfYuQ2eN8r6RyqkRD2Htik5lN6OuLSU2d6emQfWDXlkJRUsUcNEfj95rZ3+9uVj8ytmLa34tU0pM9x9x3mmRSaIXUFZyE53ddd8l7oloZ1/4XS22Fng16EhiwAy1WQ/Z01EWa0zup+5vReMDhp5OwtX5P2uo=
Message-ID: <39f633820606290818g1978866ap@mail.gmail.com>
Date: Thu, 29 Jun 2006 17:18:59 +0200
From: "Robert Nagy" <robert.nagy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Intel RAID Controller SRCU42X in SGI Altix 350
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Distribution: Debian testing/unstable
Hardware Environment: SGI Altix 350, 2xItanium 2, EFI (read dmesg)
http://bsd.hu/~robert/altix.dmesg
http://bsd.hu/~robert/altix.kconf

Problem Description: I've installed an Intel(r) RAID Controller SRCU42X (PCI-X)
controller to this machine.
http://www.intel.com/design/servers/raid/srcu42x/index.htm
I've never used such a controller so if someone has any idea about this please
tell me. The dmesg will show everyhing, but:

megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.8 (Release Date: Mon Apr 11 12:27:22 EST 2006)
megaraid: probe new device 0x1000:0x0407:0x8086:0x0532: bus 2:slot 0:func 0
megaraid: out of memory, megaraid_alloc_cmd_packets 965
megaraid: maibox adapter did not initialize

0001:01:01.0 Co-processor: Silicon Graphics, Inc. IOC4 I/O controller (rev 4f)
0001:01:03.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel Ultra3
SCSI Processor (rev 06)
0001:01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
0002:01:02.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 03)
0002:02:00.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 02)

Thanks

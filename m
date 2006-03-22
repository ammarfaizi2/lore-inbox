Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWCVCfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWCVCfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 21:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWCVCfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 21:35:05 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:15563 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751890AbWCVCfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 21:35:04 -0500
Message-ID: <4420B7D6.4020706@comcast.net>
Date: Tue, 21 Mar 2006 21:35:02 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: libata ignores non-dma disks?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.6.16-rc6-ide1 (alan's patchset) and using the sata_nv and
pata_amd drivers.  I have all UDMA drives except a CF disk -> IDE
interface, which should be running in PIO mode4.   Libata detects the
device, but spits out a message about "no dma" and then says it's not
supported and is ignoring it.   Is this device not supported because
it's not using dma or for some other reason?
It's the only device on it's channel (secondary pata)

ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
ata6: dev 0 cfg 49:0e00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0000
ata6: no dma
ata6: dev 0 not supported, ignoring
scsi5 : pata_amd


I'd really like to get this up and running so if anyone has any
suggestions, I'm all ears.



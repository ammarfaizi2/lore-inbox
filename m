Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVJREOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVJREOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVJREOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:14:04 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:23431 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751367AbVJREOD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:14:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KUgNn2V8/BT+rec6waIHPNjytN4s+OeYh0TWRzF1CuDKB4l8IbnxKPJs1kZgcjBMOvhA0cD0zuseRUi4OOzxDW+BRAxS5HPQCWdqSk2Cq59J22w8gYcLyx5/I9471qFjTtchpJg4TrXInmoKijwyzPNgLVCQT4+D59KloKXd/1s=
Message-ID: <7a37e95e0510172114p6c2da139g5266e617fd9a7163@mail.gmail.com>
Date: Tue, 18 Oct 2005 09:44:02 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why do we need libata to access SATA host controller low level device drivers?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everybody

I'm sorry if my question sounds absurd to some. I've found out through
web sources, for the following reasons/features we need libata,

[1] libata is a library used inside the linux kernel to support ATA
host controllers and devices.
[2] libata provides an ATA driver API, class transport for ATA and
ATAPI devices and SCSI<->ATA translation for ATA devices according to
the T10 SAT spec.
[3] libata causes each SATA to appear as a SCSI bus.
[4] It controls how the low-level driver interfaces with the ATA and
SCSI layers.
[5] libata supports the necessary "lba48" ATA addressing extension
starting with kernel version 2.6.5-rc2.
[6] libata has hotplug & random task file submission(thus enabling
SMART support).
SOURCE KEY:[1][2][4]libata.pdf
[3][5][6]http://linuxmafia.com/faq/Hardware/sata.html

But still at the back of my curious mind I'm looking for the most
appropriate answer to this question that can come only come from the
experienced linux kernel  experts of this group.

Now some info about myself, i'm a software engineer in india and
developing GPL'ed (open source and Linux Kernel 2.4 based) SATA
low-level driver for a SATA/ATAPI-6 Host Controller on a ARM 920TDMI
based chipset.

Looking forward for your replies and guidance. Thanks.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVAKMoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVAKMoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 07:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVAKMoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 07:44:38 -0500
Received: from host234-143.pool8250.interbusiness.it ([82.50.143.234]:39297
	"EHLO zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S262483AbVAKMog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 07:44:36 -0500
Message-ID: <41E3C90A.2010703@abinetworks.biz>
Date: Tue, 11 Jan 2005 13:39:38 +0100
From: "Ing. Gianluca Alberici" <alberici@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bad disks or bug ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i have a little doubt on the following....

/> Sep 10 12:50:30 abivrs0 kernel: hdb: dma_intr: status=0x51 { DriveReady /
/> SeekComplete Error } /
/> Sep 10 12:50:30 abivrs0 kernel: hdb: dma_intr: error=0x40 /
////

...Of course the explanation of such an error is that drive has bad
sectors and i'd better change it BUT:

I have many production servers running 2.4.27, everything seems OK while
they're new.
After about an year of production many of them (5 of them at present)
begin to show the problem BUT:

1) All of them show the problem on hdb (ALL OF THEM)
2) Never had problems on hda on ANY server, disks are the same, same
size, same partitioning
3) Typically hdb is used as a disk mirror
4) Many times a mkfs.ext3 -c -c solves the problem bringing bad sectors
to a new life !

How do you explain that ? Overload on hdb due to mirroring and surface
degradation ?
OR a kind of vodoo on my hdbs ?

NOTE: Over the internet, when i searched for such errors on disks (not
ramdisks or loop devs) i ALWAYS found problems on hdb !!!

Could it be depending on master-slave configuration ? Kernel bug ? Other ?

What do you say ?

thanks for your time,

Gianluca Alberici



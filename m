Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUFXOaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUFXOaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUFXOaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:30:05 -0400
Received: from mail.interware.hu ([195.70.32.130]:58547 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP id S264561AbUFXOaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:30:01 -0400
From: =?iso-8859-2?Q?Beliczay_Andr=E1s?= <abeliczay@ixpert.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Initrd image cannot be loaded
Date: Thu, 24 Jun 2004 16:29:47 +0200
Organization: Ixpert Internet Solutions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
thread-index: AcRZ97MQIjtwpSDzRuyBAGV79O3VJQ==
Message-Id: <S264561AbUFXOaB/20040624143001Z+1039@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
 
I installed linux kernel 2.4.26 on a Supermicro 6013P-T server with 1GB RAM.
I have a 3ware 8506 SATA RAID controller in it. So I have to use initrd to
load scsi modules and 3w-xxxx driver. With kernel 2.4.22 works everything
fine. With kernel 2.4.26 booting stops with kernel panic because cannot
mount root partition. At next boot I checked the booting process and saw
that initrd cannot be loaded because of some memory problem. Here is the
error message:
initrd extends beyond end of memory (0xc1d80000 > 0xc1d00000)
disabling initrd

(The 0xc1.. addresses is just examples because I don't have the exact
numbers with me here.)

What has been changed from 2.4.22 to 2.4.26? How can I solve this problem? 
 
Thanks,
Andras Beliczay


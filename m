Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSLFNb3>; Fri, 6 Dec 2002 08:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSLFNb3>; Fri, 6 Dec 2002 08:31:29 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:33540 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S262620AbSLFNb3>;
	Fri, 6 Dec 2002 08:31:29 -0500
Message-Id: <5.2.0.9.0.20021206141716.00a09df0@mail.science.uva.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 06 Dec 2002 14:36:31 +0100
To: rusty Russell <rusty@rustcorp.com.au>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: 2.5.50bk5 cannot insert module aha152x
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this error when I try to load the aha152x module:
# modprobe aha152x io=0x140 irq=9
FATAL: Error inserting aha152x (/lib/modules/2.5.50bk5/kernel/aha152x.ko): 
No such device

and this message appears in dmesg:
scsi HBA driver Adaptec 152x SCSI driver; $Revision: 2.5 $ didn't set 
max_sectors, please fix the template

Is this trivial to fix or has something fundamental changed?

BTW 2.5.50 did not give this message, but did not load the module either

tools:
module-init-tools 0.9.1
gcc 3.2
binutils 2.13

If you need more info, please ask

	Rudmer


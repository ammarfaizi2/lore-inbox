Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbSLGJwK>; Sat, 7 Dec 2002 04:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbSLGJwK>; Sat, 7 Dec 2002 04:52:10 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:35588 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S267739AbSLGJwA>;
	Sat, 7 Dec 2002 04:52:00 -0500
Message-Id: <5.2.0.9.0.20021207105421.00a44ec0@legolas>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 07 Dec 2002 10:56:59 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: 2.5.50bk5 cannot insert module aha152x
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.0.20021206141716.00a09df0@mail.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:36 6-12-02 +0100, Rudmer van Dijk wrote:
>I get this error when I try to load the aha152x module:
># modprobe aha152x io=0x140 irq=9
>FATAL: Error inserting aha152x (/lib/modules/2.5.50bk5/kernel/aha152x.ko): 
>No such device

ok, my mistake: after upgrading to 2.5.50bk5 I forgot to reapply the 
module-param patches... now it works!

>and this message appears in dmesg:
>scsi HBA driver Adaptec 152x SCSI driver; $Revision: 2.5 $ didn't set 
>max_sectors, please fix the template

and this is something of the driver but does no harm.

         Rudmer 


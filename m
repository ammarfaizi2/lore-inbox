Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293251AbSBWXBp>; Sat, 23 Feb 2002 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293254AbSBWXBg>; Sat, 23 Feb 2002 18:01:36 -0500
Received: from jalon.able.es ([212.97.163.2]:37601 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293251AbSBWXB2>;
	Sat, 23 Feb 2002 18:01:28 -0500
Date: Sun, 24 Feb 2002 00:01:21 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Dieter =?iso-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hang on floppy access, patched 2.4.18-rc[34]
Message-ID: <20020224000121.E2023@werewolf.able.es>
In-Reply-To: <200202232008.52370.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
In-Reply-To: =?iso-8859-15?Q?=3C200202232008=2E52370=2E?=
	=?iso-8859-15?Q?Dieter=2ENuetzel=40hamburg=2Ede=3E=3B_from_Dieter=2ENuetz?=
	=?iso-8859-15?Q?el=40hamburg=2Ede_on_s=E1b?=
	=?iso-8859-15?Q?=2C?= feb 23, 2002 at 20:08:52 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020223 Dieter Nützel wrote:
>You wrote:
>>Hi.
>>
>> My system is locking up when trying to access the floppy drive.
>> The mount or mkfs command just get stuck, no response to ctrl-c.
>> Kernel is 2.4.18-rc3 with vm-25, sched-O1, read-latency, mini-lowlat,
>> irqrate-A1. But is also hangs on rc4 without irqrate-A1.
>> Decoded output from SysRQ-P follows:
>
>How did you get the SysRQ-P output?

>From X ssession, and results whent to syslog.

>Didn't it lock up "hard"?
>

No, just the process acessing the floppy.

>-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc4-jam1 #1 SMP Sat Feb 23 16:25:56 CET 2002 i686

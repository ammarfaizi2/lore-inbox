Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130245AbQLMN1m>; Wed, 13 Dec 2000 08:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131157AbQLMN1b>; Wed, 13 Dec 2000 08:27:31 -0500
Received: from 194.38.82.urbanet.ch ([194.38.82.193]:32273 "EHLO
	internet.dapsys.com") by vger.kernel.org with ESMTP
	id <S130245AbQLMN1W> convert rfc822-to-8bit; Wed, 13 Dec 2000 08:27:22 -0500
From: Edouard Soriano <e_soriano@dapsys.com>
Date: Wed, 13 Dec 2000 13:55:10 GMT
Message-ID: <20001213.13551000@dap20.dapsys.com>
Subject: Re: PROBLEM: SCSI SYM53C896 driver, kernel 2.2.17
To: Vladimir Parkhomenko <vparch@lsto.nkmz.donetsk.ua>
CC: <linux-kernel@vger.kernel.org>
In-Reply-To: <000c01c06501$f9667cf0$0f1b10ac@nkmz.donetsk.ua>
In-Reply-To: <000c01c06501$f9667cf0$0f1b10ac@nkmz.donetsk.ua>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I just got working an ASUS Dual Pentium Motherboard with a dual channel 
SCSI controller managed
by this driver.

Additional information required:

a) kind of SCSI interfce used: SCSI-II, SCSI-III (LVD) ?
b) Make sure you do not have hardware troubles like having a 80MBs drive 
on the same
channel as a 40 Mbs.
c) sym53c896 driver version ? When using SCSI-III LVD with 80MBs or 
higher I recommend to use 1.6b

Wait for that information

Cpaciba


>>>>>>>>>>>>>>>>>> Message d'origine <<<<<<<<<<<<<<<<<<

Le 12/13/00, à 1:41:08 PM h, "Vladimir Parkhomenko" 
<vparch@lsto.nkmz.donetsk.ua> vous a écrit sur le sujet suivant PROBLEM: 
SCSI SYM53C896 driver, kernel 2.2.17:


> Good day.

> Please help me.
> Or tell me about how and where can I get consultation for the problem.
> I have small problem with my SCSI driver SYM53C896 on Linux system - 
kernel
> 2.2.17.
> When I copy huge file (about 1Gb, but < 1.5Gb) from one disk drive to 
other
> is error occured. Perfomance SYM53C896 is very slowly (from 20Mb/s to
> 4Mb/s), but the connect is being. The system log message and '/proc'
> information is attache to this mail.


> sorry for my english.

> with best regards
> Vladimir Parkhomenko
> 13.12.y2
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

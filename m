Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSIFJkp>; Fri, 6 Sep 2002 05:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318447AbSIFJkp>; Fri, 6 Sep 2002 05:40:45 -0400
Received: from koala.ichpw.zabrze.pl ([195.82.164.33]:262 "EHLO
	koala.ichpw.zabrze.pl") by vger.kernel.org with ESMTP
	id <S318435AbSIFJkn>; Fri, 6 Sep 2002 05:40:43 -0400
Message-Id: <200209060945.g869jIk28643@koala.ichpw.zabrze.pl>
From: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 06 Sep 2002 11:45:58 -0400 (EDT)
Reply-To: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
X-Mailer: (Demonstration) PMMail 2.00.1500 for OS/2 Warp 3.00
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_=_=_=IMA.BOUNDARY.H20X4M138764=_=_=_"
Subject: cdrom problem in 2.4.20-pre5-ac1,ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--_=_=_=IMA.BOUNDARY.H20X4M138764=_=_=_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit


 Repeatable system crash when I am trying to copy
 files from cdrom  ( tested on different discs - no media errors ) 
 using  2.4.20-pre5-ac1  or   ac2   .
   [ full log in attached file ]

  With 2.4.19-rc3-ac4  all is OK

Sep  5 19:11:48 bulma kernel: kernel BUG in header file at line 157
Sep  5 19:11:48 bulma kernel: kernel BUG at panic.c:286!
Sep  5 19:11:48 bulma kernel: invalid operand: 0000
Sep  5 19:11:48 bulma kernel: CPU:    0
Sep  5 19:11:48 bulma kernel: EIP:    0010:[__out_of_line_bug+15/32] 
  Not tainted
Sep  5 19:11:48 bulma kernel: EFLAGS: 00010286
....

then 

Sep  5 19:12:18 bulma kernel:  scsi : aborting command due to timeout
: pid 41, scsi1, channel 0, id 0, lun 0 Read (10) 00 00 01 3a 2e 00
00 0c 00 
Sep  5 19:12:44 bulma kernel: Unable to handle kernel paging request
at virtual address 55550073
Sep  5 19:12:44 bulma kernel:  printing eip:
Sep  5 19:12:44 bulma kernel: c0111713
Sep  5 19:12:44 bulma kernel: *pde = 00000000
Sep  5 19:12:44 bulma kernel: Oops: 0000
Sep  5 19:12:44 bulma kernel: CPU:    0
Sep  5 19:12:44 bulma kernel: EIP:    0010:[__wake_up+51/96]    Not
tainted
Sep  5 19:12:44 bulma kernel: EFLAGS: 00010002
...
and a lot of  

Sep  5 19:12:48 bulma kernel: SCSI host 1 abort (pid 41) timed out -
resetting
Sep  5 19:12:48 bulma kernel: SCSI bus is being reset for host 1
channel 0.
Sep  5 19:12:49 bulma kernel: scsi : aborting command due to timeout
: pid 41, scsi1, channel 0, id 0, lun 0 Read (10) 00 00 01 3a 2e 00
00 0c 00 
Sep  5 19:12:49 bulma kernel: SCSI host 1 abort (pid 41) timed out -
resetting
Sep  5 19:12:49 bulma kernel: SCSI bus is being reset for host 1
channel 0.
Sep  5 19:12:49 bulma kernel: scsi : aborting command due to timeout
: pid 41, scsi1, channel 0, id 0, lun 0 Read (10) 00 00 01 3a 2e 00
00 0c 00 
Sep  5 19:12:49 bulma kernel: SCSI host 1 abort (pid 41) timed out -
resetting
Sep  5 19:12:49 bulma kernel: SCSI bus is being reset for host 1
channel 0.
Sep  5 19:12:50 bulma kernel: scsi : aborting command due to timeout
: pid 41, scsi1, cSep  5 19:13:45 bulma kernel: SCSI bus is being
reset for host 1 channel 0.


--------------------------------------------------------
 Marek Mentel  mmark@koala.ichpw.zabrze.pl  2:484/3.8          
 INSTITUTE FOR CHEMICAL PROCESSING OF COAL , Zabrze , POLAND
 NOTE: my opinions are strictly my own and not those of my employer



--_=_=_=IMA.BOUNDARY.H20X4M138764=_=_=_
Content-Type: application/octet-stream; name="log.gz"
Content-Transfer-Encoding: base64

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
D58Q2N3e/2CvHzEf4u7O6wAA

--_=_=_=IMA.BOUNDARY.H20X4M138764=_=_=_--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRACChY>; Tue, 2 Jan 2001 21:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131391AbRACChO>; Tue, 2 Jan 2001 21:37:14 -0500
Received: from pm3-10-28.apex.net ([209.250.42.43]:7940 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129370AbRACCg5>; Tue, 2 Jan 2001 21:36:57 -0500
Date: Tue, 2 Jan 2001 20:06:43 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] in __switch_to with 2.4.0-prerelease
Message-ID: <20010102200643.A360@hapablap.dyn.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

    This oops occurred just a few minutes ago under no particular load.
There were actually two oopsen, but I've included only the first as I've
heard that successive oops really aren't helpful.  Nonetheless, if
anyone's interested in seeing it, I have it captured.
    These oops were processed by syslog, if that's a problem.  Not sure
if its repeatable.  This is these are the first and only oops I've had
with -prerelease, otherwise it has been very stable.
    The system is 500MHz K6/2, 64MB RAM.
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=oops

 printing eip:
c01076c9
Oops: 0002
CPU:    0
EIP:    0010:[__switch_to+33/180]
EFLAGS: 00010886
eax: c2e9c260   ebx: 614fa060   ecx: c2cbe2c0   edx: c347a000
esi: c2e9bfff   edi: c347a000   ebp: c2e9df1c   esp: c347bed4
ds: 0018   es: 0018   ss: 0018
Process panel (pid: 2016, stackpage=c347b000)
Stack: c2e9c000 c2cbe1c0 c2e9c000 c2e9df1c c2e9c260 c0111fd0 c347bf1c c347a000 
       c2cbe2c0 c347bf30 010b626a 081b99c0 c07d8000 c1164720 c2cbe2c0 00000002 
       00000000 c0261540 c347bf44 c0111d4a c347bf30 00000000 c0762aa0 c0268734 
Call Trace: [schedule+604/908] [schedule_timeout+114/144] [process_timeout+0/72] [do_poll+184/216] [sys_poll+470/724] [system_call+51/64] 
Code: 00 0c 08 60 00 00 00 b0 89 ca 08 60 4f 73 08 60 4f 73 08 74 

--MGYHOYXEY6WxJCY8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

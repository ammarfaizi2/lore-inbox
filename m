Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129491AbRBSOpg>; Mon, 19 Feb 2001 09:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRBSOp0>; Mon, 19 Feb 2001 09:45:26 -0500
Received: from [200.43.18.234] ([200.43.18.234]:9736 "EHLO
	radius.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S129491AbRBSOpL>; Mon, 19 Feb 2001 09:45:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops
Message-ID: <982593844.3a9131343a98c@webmail.telpin.com.ar>
Date: Mon, 19 Feb 2001 11:44:04 -0300 (ARST)
From: Alberto Bertogli <albertogli@telpin.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I got an oops in a Dell PowerEdge 4100/200.
It was almost idle (the process list is listed below).
There was no SysRQ, VT, hd work, network or keyboard response.
The oops was, obviously, copied by hand; and kernel is
plain 2.4.1 compiled with egcs 2.91.66.

uname -a:
Linux sol 2.4.1 #3 SMP Wed Feb 14 18:14:33 ARST 2001 i686 unknown

Hardware:
2xiPPro 200mhz
128Mb ram
Intel eepro100
(dmesg attached)

process list:
syslogd
klogd 
httpd 
 \_ 5x httpd
crond
atd
bash 
 \_ mailsnarf 
bash
agetty
agetty
agetty
bash
 \_ vmstat 1
inetd

Attached are the plain oops, the oops passed through ksymoops, the dmesg
output and the kernel config.

Thanks,
        Alberto

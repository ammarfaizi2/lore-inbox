Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281611AbRKMMC6>; Tue, 13 Nov 2001 07:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281612AbRKMMCt>; Tue, 13 Nov 2001 07:02:49 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:57274 "EHLO
	c0mailgw07.prontomail.com") by vger.kernel.org with ESMTP
	id <S281611AbRKMMCb>; Tue, 13 Nov 2001 07:02:31 -0500
X-Version: beer 7.5.2333.0
From: "william fitzgerald" <william.fitzgerald3@beer.com>
Message-Id: <6169641FA9FA29E43946AEB269F1EA2E@william.fitzgerald3.beer.com>
Date: Wed, 14 Nov 2001 12:07:19 +2400
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: linux-kernel@vger.kernel.org
Subject: printk performance logging without syslogd for router
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

(perforamnce logging of network stack through a
linux router)

the main question:

is there a way i can buffer or record  the printk
statements and print them to disk  after my
packets have gone through the router?

my understanding of printk is that each time it
is encountered it is written to disk by syslogd
as i have been told by Erik .so for a lot of
packets there will be alot of writes,therefore
slowing the system and producing false results.

so lets cut out syslogd and just use the -f
option on klogd.
does this decrease the huge slow down of 
writting printk's?

basically is there a way i can buffer or record 
the printk statements and print them to disk 
after my packets have gone through the router?
  do i edit the printk.c file and change the 
line:

                          static char buf[1024];
  and increase the size of the array?

 or do i edit the klogd.c program and change
 something in there?

i'm still at a loose end!

many thanks in advance,
will.





Beer Mail, brought to you by your friends at beer.com.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRKHPgk>; Thu, 8 Nov 2001 10:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRKHPgb>; Thu, 8 Nov 2001 10:36:31 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:31624 "EHLO
	c0mailgw08.prontomail.com") by vger.kernel.org with ESMTP
	id <S274194AbRKHPgS>; Thu, 8 Nov 2001 10:36:18 -0500
X-Version: beer 7.5.2333.0
From: "william fitzgerald" <william.fitzgerald3@beer.com>
Message-Id: <073EAB4D8C9C4A14CBAAC7C9C97D8242@william.fitzgerald3.beer.com>
Date: Fri, 9 Nov 2001 15:41:17 +2400
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: linux-kernel@vger.kernel.org
Subject: printk kernel logging for router
CC: williamf@cs.may.ie
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
linux newbie here.

i need to know some information in regard to
logging with printk statements.

my plan is to monitor the performance of a linux
router.i'm adding printk  statements to the
kernel to every function that is called by
forwarding packets and in that way find precisely
where a packet or packets  get lost.

 this is still in progress.

when i finally get all my printk statements in, i
want to be able to flood my router on my own mini
network.(router running on a p133 using
redhat7.1)

my understanding of printk is that each time it
is encountered it is written to disk.so for a lot
of packets there will be alot of writes,
therefore slowing the system and producing false
results.

so how to i buffer or record  the printk
statements and print them to disk  after my
packets have gone through the router?

 do i edit the printk.c file and change the 
line:

                          static char buf[1024];

and increase the size of the array?
or do i edit the klogd.c program and change
something in there?

 many thanks in advance and all comments no
matter how trivial  are welcome in  order for me
to learn more.

regards william.

Beer Mail, brought to you by your friends at beer.com.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265620AbRF1Jvy>; Thu, 28 Jun 2001 05:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265617AbRF1Jvo>; Thu, 28 Jun 2001 05:51:44 -0400
Received: from koala.ichpw.zabrze.pl ([195.82.164.33]:21775 "EHLO
	koala.ichpw.zabrze.pl") by vger.kernel.org with ESMTP
	id <S265583AbRF1Jvh>; Thu, 28 Jun 2001 05:51:37 -0400
Message-Id: <200106280957.f5S9v3c11696@koala.ichpw.zabrze.pl>
From: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 28 Jun 2001 11:52:51 -0400 (EDT)
Reply-To: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
X-Mailer: (Demonstration) PMMail 2.00.1500 for OS/2 Warp 3.00
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Subject: error compiling 2.2.20pre5, pre6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling kernel 2.20pre5, pre6 :

drivers/net/net.a(8139too.o): In function `rtl8139_thread':
8139too.o(.text+0x10ff): undefined reference to `lock_kernel'
8139too.o(.text+0x1116): undefined reference to `unlock_kernel'
make: *** [vmlinux] Error 1

lack of 
     #include <linux/smp_lock.h>
  in  8139too.c ?
--------------------------------------------------------
 Marek Mentel  mmark@koala.ichpw.zabrze.pl  2:484/3.8          
 INSTITUTE FOR CHEMICAL PROCESSING OF COAL , Zabrze , POLAND
 NOTE: my opinions are strictly my own and not those of my employer




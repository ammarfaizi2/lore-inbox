Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRLQQPw>; Mon, 17 Dec 2001 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281116AbRLQQPj>; Mon, 17 Dec 2001 11:15:39 -0500
Received: from [210.0.172.57] ([210.0.172.57]:23051 "EHLO dog.ima.net")
	by vger.kernel.org with ESMTP id <S281005AbRLQQPa>;
	Mon, 17 Dec 2001 11:15:30 -0500
Date: Tue, 18 Dec 2001 00:16:12 -0800 (GMT+8)
From: Joe Wong <joewong@tkodog.no-ip.com>
X-X-Sender: <joewong@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: compling kernel module against different kernel settings
Message-ID: <Pine.LNX.4.33.0112180014080.1379-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Hi,

     I am quite new to linux kernel build procedure and please forgive me
   if my question is too _easy_.

     From what I know I can change different parameters to build kernel by
   make xconfig/make menuconfig/make config.

     The above proesses will generate different settings in .config and
   autoconf.h. Now I want to build my loadable kernel module against
   different kernel settings ( like CPU type, SMP support or not and so..
   ). Is this possible to automate all of the steps involed?

     I found out that 'make dep' does not update *.ver in
   ./include/linux/modules/ and I have to use make mrproper but it will
   delete everthing..

     Or, I should build a generic module that can run on different kernel
   settings? I am quite confuse and hope someone can give me a hand on
   this.

   TIA.

   - Joe




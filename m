Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281161AbRKHALE>; Wed, 7 Nov 2001 19:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKHAKy>; Wed, 7 Nov 2001 19:10:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39307 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281161AbRKHAKh>;
	Wed, 7 Nov 2001 19:10:37 -0500
Date: Wed, 07 Nov 2001 16:09:50 -0800 (PST)
Message-Id: <20011107.160950.57890584.davem@redhat.com>
To: tim@physik3.uni-rostock.de
Cc: jgarzik@mandrakesoft.com, andrewm@uow.edu.au, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, adilger@turbolabs.com, netdev@oss.sgi.com,
        ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0111080003320.29364-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.30.0111080003320.29364-100000@gans.physik3.uni-rostock.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Schmielau <tim@physik3.uni-rostock.de>
   Date: Thu, 8 Nov 2001 01:00:24 +0100 (CET)

   jiffies cleanup patch of the day follows. Mostly boring changes of jiffies
   comparisons to use time_{before,after} in order to handle jiffies
   wraparound correctly.

These cases handle wraparound correctly!!!!

Please stop sending these changes, start thinking about what the
code is doing.

It is comparing a "DIFFERRENCE" not raw jiffy values with each other.
It works just fine.

Franks a lot,
David S. Miller
davem@redhat.com

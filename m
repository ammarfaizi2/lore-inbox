Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263961AbRFKUId>; Mon, 11 Jun 2001 16:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263957AbRFKUIY>; Mon, 11 Jun 2001 16:08:24 -0400
Received: from gandalf.uznam.net.pl ([195.205.28.2]:12807 "EHLO
	gandalf.uznam.net.pl") by vger.kernel.org with ESMTP
	id <S263870AbRFKUIN>; Mon, 11 Jun 2001 16:08:13 -0400
Date: Mon, 11 Jun 2001 22:03:01 +0200
From: Michal Margula <alchemyx@uznam.net.pl>
To: linux-kernel@vger.kernel.org
Subject: Disaster under heavy network load on 2.4.x
Message-ID: <20010611220301.A6852@cerber.uznam.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

My friend told me to noticed you about problems I had with 2.4.x line of
kernels. I started up from 2.4.3. Under heavy load I was getting
messages from telnet, ping, nmap "No buffer space available". Strace
told me it was error marked as ENOBUFS.

First thought was it was my fault. I asked many people and nobody could
help me. So I tried 2.4.5. It was a disaster also (should I mention few
oopses?:>).

Second thought was to try 2.2.19 and it was good choice. Now there are
almost no messags like those above. Only thing that still happens is
"Neihgbour table overflow".

Some data about my Linux box:

2 x PIII 800 MHz/1024 MB; 2 x Intel EExpres 100; 3 x 3com 3c900B-Combo.
Summarizing all traffic about 5mbit at the moment.

# arp -an | wc -l
   1018

Any more info needed?

PS. It would be nice to be CCed with replies, beacause I am not
subscribed to LKML.

-- 
Michal Margula, alchemyx@uznam.net.pl, ICQ UIN 12267440, +)
http://uznam.net.pl/~alchemyx/, Polish section of Linux Counter maintainer

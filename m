Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276184AbRJCNAR>; Wed, 3 Oct 2001 09:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276176AbRJCNAH>; Wed, 3 Oct 2001 09:00:07 -0400
Received: from lambik.cc.kuleuven.ac.be ([134.58.10.1]:17418 "EHLO
	lambik.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S276181AbRJCM7x>; Wed, 3 Oct 2001 08:59:53 -0400
Message-Id: <200110031300.PAA17063@lambik.cc.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
To: linux-kernel@vger.kernel.org
Subject: mtu problem with masquerading+pppoe(adsl) setup
Date: Wed, 3 Oct 2001 15:00:17 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello, (i am sorry if this is the wrong place to ask)
 
 despite the frequent discussions concerning this topic on usenet, i failed 
 to solve my problem:
 
 - i have a debian potatoe box that acts as a masquerading server for a 
 heterogenous win2k/winnt/mac LAN. pppoe works fine, and so does 
 masquerading ... almost
 
 - the kernel i installed is the latest 2.2 kernel (2.2.19)
 
 the problem:
 
 i can't access some sites from the masq clients, while i can access them 
 from the masq server. (like www.vitrine.be)
 
 The problem seems to be widely known, and seems to be an MTU+no-fragment 
 packets issue. and indeed:
 - the MTU on my LAN is 1500 bytes
 - the MTU on my ppp connection is 1492 bytes.
 
 on the archives, i found the following solutions:
 - raising the ppp MTU to 1500 bytes. it won't work. even if i specify 1500, 
 the mtu is still 1492.
 - lowering the mtu of the LAN to 1492 bytes. thats not an option according 
 to my boss.
 - upgrade to something newer than 2.2.14. i run 2.2.19 and i still have the 
 problem.
 
 So my questions are:
 
 - are there other options ? i read some vague german things about msschamp 
 or something like that, but i don't know if they are even related.
 
 - will an upgrade to linux 2.4 or the kernelspace pppoe driver fix my 
 problem ? (i would like to keep my current setup, i don't know how 
 difficult it is to upgrade a potatoe box to such a recent version ..)
 
 
 Some other observations:
 
 - win2k as masquerading server does not have the problem, but switching to 
 win2k is not really an option since win2k seems to have severe problems 
 with ftp connections.
 
 - the problem also occurs for some mail servers.
 
 
 Thanks in advance,
 
 Frank Dekervel
 
 
 
 -- 
 Frank Dekervel
 Mechelsestraat 88
 3000 Leuven
 frank.dekervel@student.kuleuven.([nospam]).ac.be

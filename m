Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271799AbRH1QQx>; Tue, 28 Aug 2001 12:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271802AbRH1QQn>; Tue, 28 Aug 2001 12:16:43 -0400
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:18762 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S271799AbRH1QQ2>; Tue, 28 Aug 2001 12:16:28 -0400
Date: Tue, 28 Aug 2001 18:16:34 +0200 (CEST)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
Reply-To: Oliver Paukstadt <oliver@paukstadt.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: NFS Client and SMP
Message-ID: <Pine.LNX.4.05.10108281806180.20438-100000@lara.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HY HY

I have massive problems using client nfs on SMP boxes.
I can reproduce it 2.4.[0-7] on s390 and s390x and with 2.4.[0-8] on IA32.

Try to reproduce starting massive IO on an nfs mounted volume, eg. tar it
to /dev/null.
I tested it against verious servers, eg Slowlaris, HP-UX, DEC, Linux 2.2,
Linux 2.4, no tar survived.
using NFS v2 or v3 caused no differences.
One Intel we have to identical machines with identical setup and only the
box locks up running nfs client (we switched the roles of the boxes)

On S390 it took 5 to 30 minutes to lock the system, on Intel sometimes it
took up to 3 hours.

Running the system with only one cpu caused no hangs, all tars finished.

BYtE Oli

+++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++Manchmal stehe ich sogar nachts auf und installiere mir eins....+++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 


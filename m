Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312850AbSDCB1J>; Tue, 2 Apr 2002 20:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312871AbSDCB07>; Tue, 2 Apr 2002 20:26:59 -0500
Received: from sjvuapcd-9.sjvuapcd.dst.ca.us ([209.135.18.10]:21509 "EHLO
	sjvuapcd-9.sjvuapcd.dst.ca.us") by vger.kernel.org with ESMTP
	id <S312850AbSDCB0r>; Tue, 2 Apr 2002 20:26:47 -0500
Message-ID: <41B39C480A48D3119D9B00805FBBA6091221E068@sjvapcd-mail.valleyair.org>
From: Staven Bruce <Staven.Bruce@valleyair.org>
To: linux-kernel@vger.kernel.org
Subject: Nic Issue?
Date: Tue, 2 Apr 2002 17:25:16 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-OriginalArrivalTime: 03 Apr 2002 01:25:58.0968 (UTC) FILETIME=[82618B80:01C1DAAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,

We are running Red Hat Linux on a Compaq ML570 with four Xeon processors and
one gigabyte of RAM. The server has two NIC cards, one compaq gigabit card
and one 3com 100Mbs card. After some help from all of you, I have been able
to successfully install and configure both NIC cards. However, I have found
that after one hour of use, the gigabit card loses all connectivity,
however, the 3com card stays up fine. We have tested this scenario several
times, and the gigabit card is definitely dropping connectivity after about
an hour. The only way to bring it back is to reboot the box, in which case
they both work fine, but only for about an hour, then the gigabit loses
connectivity again.

I checked out the Compaq website for a new driver, and there was one
available, however, when I tried to build it with the 'make install' command
from the created directory which contained the Makefile, I received an error
message stating that he Kernel Source was not available. I took a look at
the Makefile, and saw it was calling a 'linux' directory in /usr/src/
however, all I have is a 'redhat' directory in /usr/src/. I copied the
contents of the 'redhat' directory to a new directory called 'linux' and
still I had the same problem.

I am running out of ideas, and was hoping someone out there might have run
into this problem before, either with multiple NICS or with Compaq RPMS.

Any info would really help!

Thanks,

Staven 

-
Staven Bruce
Network Systems Analyst

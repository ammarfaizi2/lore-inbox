Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbRBNWHj>; Wed, 14 Feb 2001 17:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131281AbRBNWHa>; Wed, 14 Feb 2001 17:07:30 -0500
Received: from think.faceprint.com ([166.90.149.11]:12307 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S130344AbRBNWHZ>; Wed, 14 Feb 2001 17:07:25 -0500
Message-ID: <3A8B019C.4F0C76DB@faceprint.com>
Date: Wed, 14 Feb 2001 17:07:24 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac13 tulip problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted to 2.4.1-ac13, and was fine for a couple minutes.  Then
all network connectivity went away, and I had this sitting in syslog:


Feb 14 16:45:48 patience kernel: LDT allocated for cloned task!
Feb 14 16:47:19 patience kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 14 16:47:51 patience last message repeated 4 times
Feb 14 16:48:55 patience last message repeated 8 times
Feb 14 16:49:59 patience last message repeated 8 times
Feb 14 16:51:03 patience last message repeated 8 times
Feb 14 16:51:51 patience last message repeated 6 times
<snip>
Feb 14 16:51:59 patience kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 14 16:52:31 patience last message repeated 4 times
Feb 14 16:53:35 patience last message repeated 8 times
Feb 14 16:54:39 patience last message repeated 8 times
Feb 14 16:54:47 patience kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 14 16:54:49 patience kernel: inet6_ifa_finish_destroy
Feb 14 16:54:49 patience kernel: inet6_ifa_finish_destroy
Feb 14 16:54:57 patience kernel: eth0: Setting half-duplex based on
MII#1 link partner capability of 0021.
Feb 14 16:55:15 patience kernel: eth0: no IPv6 routers present
Feb 14 16:55:15 patience kernel: eth0: no IPv6 routers present

Hence, I'm back to 2.4.1-ac12, and sending this in.  No other noticible
problems in my short-lived uptime ;-)

Nathan

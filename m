Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283188AbRK2LsN>; Thu, 29 Nov 2001 06:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283187AbRK2Lrx>; Thu, 29 Nov 2001 06:47:53 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:23759 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S283181AbRK2Lrp>; Thu, 29 Nov 2001 06:47:45 -0500
Subject: Routing table problems
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF8DFA00F6.3DAC22D2-ON65256B31.003CB38A@in.ibm.com>
From: "Rajasekhar Inguva" <irajasek@in.ibm.com>
Date: Sat, 29 Dec 2001 17:17:48 +0530
X-MIMETrack: Serialize by Router on d23m0067/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 29/11/2001 05:17:56 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am facing a problem ( ???, maybe it works that way, but i really dont
know ) with regards to routing table behavior when using ifconfig on a
network interface.

1) netstat -nr      Shows my default gateway for network 0.0.0.0

2) ifconfig eth0 down

3) netstat -nr      No entry for the default gateway is shown (
understandable )

4) ifconfig eth0 up

After the the 4'th command, my interface is up and has it's IP address set
correctly. But .....

netstat -nr  does not show my default gateway for network 0.0.0.0 !!.
Pinging any IP outside of my subnet, results in "Network is unreachable"
error.

Is is meant to be that way ? or is there a problem here ?

I've tried it on kernel versions, 2.4.0, 2.4.5 & 2.4.15

FYI : This has been tried using both DHCP and Static IP.

Thanks in advance !

Regards,

Raj



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOBxP>; Thu, 14 Dec 2000 20:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOBxF>; Thu, 14 Dec 2000 20:53:05 -0500
Received: from skuten.gs.bergen.hl.no ([193.214.40.9]:18697 "HELO
	gs.bergen.hl.no") by vger.kernel.org with SMTP id <S129267AbQLOBwu>;
	Thu, 14 Dec 2000 20:52:50 -0500
Date: 15 Dec 2000 01:22:01 -0000
Message-ID: <20001215012201.25167.qmail@gs.bergen.hl.no>
From: vidar-kernel@gs.bergen.hl.no
Cc: recipient list not shown:;
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my newly installed 2 CPU server with redhat-7.0 I have two Adaptec
quartet64 (ANA-62044) ethernet cards. Using the 2.4.0-testxx kernel I
get this kernel error for something that looks like every single packet
passing the network interface, providing vast syslog files, and makes i t impossible to use the console terminal to anything usefull, also
featuring unreliable network connection.

kernel: eth0: Internal fault: The skbuff addresses do not match in netdev_rx: 922368017 vs. f6fa3800 / f6fa3810.

The numbers changes as the errors keep coming rapidly.

I have tried the preview "2.4.0-26" kernel provided on the redhat
cd-drom, and selfcompiled versions of 2.4.0-test11 and 2.4.0-test12
kernels using

gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
glibc-2.2-5.

The network itself is kind of working, providing speed from 11.5Mbytes/ to 3-4Mbytes/s on one tp cable, but sometimes hangs for a while,
providing lousy and unreliable network performance.

The nic is currently connected with a single cat5 tp
cable to a switch, with auto-negotiation for speed and duplex enabled,
showing no errors either on the switch side nor from the output of ifconfig.

Since the network seems to be working almost fine, I believe it's just a small bug that needs to be located and fixed.

It seems to be working fairly ok the the few hours I've been running on 2.2.18 with Donald Becker's starfire.c driver.


Regards

Vidar Haugsvær
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

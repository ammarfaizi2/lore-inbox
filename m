Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132769AbRASBwy>; Thu, 18 Jan 2001 20:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132710AbRASBwo>; Thu, 18 Jan 2001 20:52:44 -0500
Received: from node10084.a2000.nl ([24.132.0.132]:11024 "EHLO caliban.org")
	by vger.kernel.org with ESMTP id <S132911AbRASBsg>;
	Thu, 18 Jan 2001 20:48:36 -0500
Date: Fri, 19 Jan 2001 02:48:35 +0100
From: Ian Macdonald <ian@caliban.org>
To: linux-kernel@vger.kernel.org
Subject: Hang when booting 2.4.0/2.4.1-pre8 on Compaq 1850R with SMART 3200
Message-ID: <20010119024835.A3655@caliban.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Fingerprint: 5549 8FFB CE82 CF71 B0D7  14E0 BB98 B98B BFBA F0E8
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently experiencing difficulty booting Linux 2.4.0 on a Compaq
1850R server with a SMART 3200 controller on board.

When the SMART array is detected and the cpqarray driver is loaded,
the system hangs at the following point:

Compaq SMART2 Driver (v 2.4.1)
Found 1 controller(s)
cpqarray ida/c0d0: blksz=512 nr_blks=17764320
Partition check:
 ida/c0d0:_

The partition check never starts.

I get the same results when booting 2.4.1-pre8. The system works fine
with the 2.2.x kernel series, but I need some of the functionality in
the newer 2.4.x series.

Any ideas?

Ian
-- 
Ian Macdonald               | Inspite of all evidence to the contrary,   
Senior System Administrator | the entire universe is composed of only two
Linuxcare, Inc.             | basic substances: magic and bullshit.      
Support for the Revolution  |                                            
                            |                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

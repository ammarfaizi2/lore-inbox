Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRA1Vei>; Sun, 28 Jan 2001 16:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143630AbRA1VeU>; Sun, 28 Jan 2001 16:34:20 -0500
Received: from mail.inconnect.com ([209.140.64.7]:62855 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S130335AbRA1Vd5>; Sun, 28 Jan 2001 16:33:57 -0500
Date: Sun, 28 Jan 2001 14:33:56 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: <linux-kernel@vger.kernel.org>
Subject: ECN fixes for Cisco gear
In-Reply-To: <20010128151835.G13195@xi.linuxpower.cx>
Message-ID: <Pine.SOL.4.30.0101281429140.6934-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In Sept of 2000, I did a survey of 30,000 websites and found that 8% of
them were unreachable from an ECN capable client.  Two major culprits were
identified, the Cisco PIX and Local Director.  To Cisco's credit, fixes
were released quickly.

Here is a message I sent with info about the Cisco updates:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.1/1205.html

Here is the fix for PIX:


(see
http://www.cisco.com/cgi-bin/Support/Bugtool/onebug.pl?bugid=CSCds23698)
    Bud ID: CSCds23698
    Headline: PIX sends RSET in response to tcp connections with ECN
 bits set
    Product: PIX
    Component: fw
    Severity: 2 Status: R [Resolved]
    Version Found: 5.1(1) Fixed-in Version: 5.1(2.206) 5.1(2.207)
 5.2(1.200)


Here is the fix for Local Director:


(see
http://www.cisco.com/cgi-bin/Support/Bugtool/onebug.pl?bugid=CSCds40921)
Bug Id : CSCds40921
 Headline: LD rejects syn with reserved bits set in flags field of TCP hdr
 Product: ld
 Component: rotor
 Severity: 3 Status: R [Resolved]
 Version Found: 3.3(3) Fixed-in Version: 3.3.3.107


Dax Kelson
Guru Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

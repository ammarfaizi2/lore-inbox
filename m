Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271714AbRIEGVO>; Wed, 5 Sep 2001 02:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271740AbRIEGVE>; Wed, 5 Sep 2001 02:21:04 -0400
Received: from host213-123-129-26.in-addr.btopenworld.com ([213.123.129.26]:5124
	"EHLO ambassador.mathewson.int") by vger.kernel.org with ESMTP
	id <S271714AbRIEGU4>; Wed, 5 Sep 2001 02:20:56 -0400
Message-Id: <200109050621.f856LAK00824@ambassador.mathewson.int>
Subject: aic7xxx errors
To: linux-kernel@vger.kernel.org
From: Joseph Mathewson <joe@mathewson.co.uk>
Reply-to: joe.mathewson@btinternet.com
Date: Wed, 05 Sep 2001 07:21:10 +0100
X-Mailer: TiM infinity-ALPHA6-rc0.8-jjm
X-TiM-Client: fusion [192.168.0.1]
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just woken up this morning to find my internet gateway machine only
responding to pings, and on giving it a keyboard & monitor, a load of

scsi0:0:1:0: Attempting to queue an ABORT message
scsi0:0:1:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194

errors.

Is this a problem with the hard drive on ID 1 or a driver issue?  It's now
working fine after a restart (eventually it seems to have given up on ID 1
completely and it restarted cleanly [it boots off ID 0]).

I'm using kernel 2.4.7, the card is an Adaptec 2940UW (aic7xxx), the drive
on ID 1 a Seagate Barracuda 18LP.

Joe.

+-------------------------------------------------+
| Joseph Mathewson <joe@mathewson.co.uk>          |
+-------------------------------------------------+

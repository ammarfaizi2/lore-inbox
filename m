Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263511AbTC3Doo>; Sat, 29 Mar 2003 22:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263512AbTC3Don>; Sat, 29 Mar 2003 22:44:43 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15323 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263511AbTC3Don>; Sat, 29 Mar 2003 22:44:43 -0500
Date: Sat, 29 Mar 2003 19:55:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 520] New: setkey -DP hangs system (fwd)
Message-ID: <196990000.1048996559@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=520

           Summary: setkey -DP hangs system
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: linux-bugs@treblig.org


Distribution: Debian
Hardware Environment: Dual Athlon MP on Tyan S2460, 3c905c net card
Software Environment: Uptodate debian/sid, ipsec-tool-0.2.2
Problem Description: System hangs (maybe oops?) on doing a setkey -DP

Steps to reproduce:
Both hangs have come when doing a

setkey -DP

I'm just trying to figure out the 2.5.x ipsec stuff.  Doing setkey -DP after
setting a pair of spd's seems OK, but then I run racoon (foreground with -F and
a few -v's) and ping a destination.  This gives an error about not being able to
setup the sa, so I kil racoon; repeat and tweak a few times, then do the setkey
-DP and it dies.


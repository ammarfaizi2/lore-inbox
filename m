Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTBRKCC>; Tue, 18 Feb 2003 05:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbTBRKCC>; Tue, 18 Feb 2003 05:02:02 -0500
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:40860 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S261292AbTBRKCB>; Tue, 18 Feb 2003 05:02:01 -0500
Date: Tue, 18 Feb 2003 10:11:59 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: linux-kernel@vger.kernel.org
Subject: "Unknown HZ value! (0) Assume 100." Wraparound bug?
Message-ID: <Pine.LNX.4.53.0302181003550.1878@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (18l5fD-0004xX-00)
X-Certificate: verified
X-uvscan-result: clean (18l4jJ-0007pL-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two of our machines (one running 2.4.18-xfs-ipsec, one running
2.4.19-pre10-ac2)  started spitting this message before some commands
(might be in Debian procps 2.0.7-8) after an uptime of about 248 days
(certainly in the latter case, probably the same in the former).

This smells a bit as about 248 is about half of about 497, which was a 
trigger (which I managed to hit :) in the mid 2.1.x series for the uptime 
counter to wrap.

Apart from the message the machines were still running fine. I rebooted 
the 2.4.18 one recently after about 330-340 days' uptime due to a power 
outage confusing its routing. The 2.4.19-pre10-ac2 one is our mail server 
and will need rebooting sooner as this bizarre message gets mailed back to 
anyone who mails any of our majordomo lists :-/

Anyway, can't grumble. Thanks for all the uptime :)

Matt

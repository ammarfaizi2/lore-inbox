Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSBCEk5>; Sat, 2 Feb 2002 23:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSBCEks>; Sat, 2 Feb 2002 23:40:48 -0500
Received: from ohiper1-27.apex.net ([209.250.47.42]:19977 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S286207AbSBCEkd>; Sat, 2 Feb 2002 23:40:33 -0500
Date: Sat, 2 Feb 2002 22:40:32 -0600
To: linux-kernel@vger.kernel.org
Subject: VIA Northing workaround /causing/ problems
Message-ID: <20020202224032.A8010@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 10:36pm  up  6:22,  0 users,  load average: 1.02, 1.05, 1.03
From: Steven Walter <srwalter@hapablap.dyn.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my kernel from 2.4.10-pre6 to 2.4.18-pre2.  After
doing so, X acted extremely weird; whenever just about anything
happened, lines would appear across the screen, almost like static.

After playing around with a few config options that I'd changed, with no
results, I noticed the message about the VIA northbridge bug in dmesg.
I commented out the line listing this chipset in pci-pc.c, recompiled,
and sure enough that fixed the problem!

This board is based on the KT33 chipset.  If anyone would like more
information, email me.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263756AbRFLXD4>; Tue, 12 Jun 2001 19:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbRFLXDq>; Tue, 12 Jun 2001 19:03:46 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:25666 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S263756AbRFLXDh>; Tue, 12 Jun 2001 19:03:37 -0400
Date: Tue, 12 Jun 2001 23:48:51 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: Via-rhine in 2.4.5 still requires cold-boot
Message-ID: <Pine.LNX.3.96.1010612234709.31447A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for the record, the via-rhine.c in 2.4.5 still does not work if you
soft-boot the computer (at least one a machine here), MAC address shows up
as 00:00:00:00:00:00 and it fails - but a cold boot (power cable off, no
standby power) makes it work.

I read something that we'd need to reload the EEPROM on the boards or
something if a cold-boot solves a problem. Well it does. :)

/BW


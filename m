Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSAPTMr>; Wed, 16 Jan 2002 14:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSAPTMl>; Wed, 16 Jan 2002 14:12:41 -0500
Received: from w172.z064003173.nyc-ny.dsl.cnc.net ([64.3.173.172]:26628 "EHLO
	worldwideweber.org") by vger.kernel.org with ESMTP
	id <S287306AbSAPTM1>; Wed, 16 Jan 2002 14:12:27 -0500
Date: Wed, 16 Jan 2002 14:56:08 -0500 (EST)
From: john e weber <john@worldwideweber.org>
To: <linux-kernel@vger.kernel.org>
Subject: linux-2.5.3-pre1 and IDE Driver Trouble
In-Reply-To: <20020107202033.18893.qmail@web10007.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0201091206030.2530-100000@worldwideweber.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linux-2.5.3-pre1 freezes when using hdparm.
The exact command issued:
/sbin/hdparm -m16 -d1 -c3 -A1 /dev/hda

Specifically, it freezes when attempting to set multimode (hdparm -m16);
all other options work fine.

This doesn't seem to be a big problem, as I have my kernel configured to   
use multi-mode by default.  So the kernel sets it to the right value (16) 
by default.

It doesn't print any messages, so please let me know if there
is anything else I should try.

I keep forgetting to send all my system info with my emails, so:

Linux 2.5.3-pre1
GCC 2.96-98
128 MB RAM
Pentium III, Intel 443BX System Chipset (Intel PIIX4 IDE Interface)

--
John Weber
(AKA weber@nyc.rr.com)                                    HOME
(AKA weber@cs.ccny.cuny.edu)                       WORK/SCHOOL
(AKA The NOTORIOUS BIG ENDIAN)             ALL AROUND DA WORLD


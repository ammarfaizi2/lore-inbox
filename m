Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312183AbSCRDJ5>; Sun, 17 Mar 2002 22:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312186AbSCRDJq>; Sun, 17 Mar 2002 22:09:46 -0500
Received: from lsanca1-220-085.lsanca1.dsl.gtei.net ([4.3.220.85]:18950 "EHLO
	vhost2.connect4less.com") by vger.kernel.org with ESMTP
	id <S312183AbSCRDJd>; Sun, 17 Mar 2002 22:09:33 -0500
Message-ID: <3C95417E.B9BFAF68@connect4less.com>
Date: Sun, 17 Mar 2002 17:23:10 -0800
From: David Christensen <davidc@connect4less.com>
Organization: Connect4Less, Inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Possible problem with isofs and CONFIG_NOHIGHMEM]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Posted this to the fsdevel list, but didn't get any bites!


After a search through the FAQ to see if this was a known issue, I
thought I should report it!

Just brought my system up to 1G of ram (1.2GHz Athlon, Abit KT7MB, 1GB
RAM, Adaptec 29160N, eepro100, SndBlstr Live) and thought I should
recompile the kernel to allow for "HIGHMEM" (4GB.)  After the compile, I
noticed I couldn't mount any CD's.  For some reason the ISO9660 driver
was getting stomped.  

I have ISO9660 compiled as a module, but it seems to be hosed with the
HIGHMEM setting in the kernel.  Changed HIGHMEM back to "off" and
ISO9660 support came back.

Any reason why?

Thanks for your response,

David Christensen

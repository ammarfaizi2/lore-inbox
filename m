Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSBHQnI>; Fri, 8 Feb 2002 11:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291637AbSBHQmt>; Fri, 8 Feb 2002 11:42:49 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:43529 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S291633AbSBHQmp>; Fri, 8 Feb 2002 11:42:45 -0500
Date: Fri, 8 Feb 2002 17:42:50 +0100
From: Florian Hars <florian@hars.de>
To: linux-kernel@vger.kernel.org
Subject: Disk-I/O and kupdated@99.9% system (2.4.18-pre9)
Message-ID: <20020208164250.GA321@bik-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ext[23] filesystem (doesn't matter which), on an LVM Volume.
Whenever I do some heavy disk-I/O (like untaring an archive with 13000
files that amount to 5GB), the CPU-state repeatedly goes to 99.9%
system and stays there for a noticeable amount of time (1-2 seconds),
during which the system doesn't respond very well to user action, to put
it mildly. 
Whenever this happens, top shows kupdated as one of the most active
processes (sometimes it also claims that top uses 54% of the CPU, but
I guess that is only marginally accurate).  bdflush (which according to
google was mentioned in connection to a similar problem some time
ago) doesn't do anything.

The system is an Athlon XP 1800+ on a Gigabyte GA7-VTXE board with
one IDE disk.
Kernel is 2.4.18-pre9, LVM utilities 1.0.1release, is there anything
else that is relevant?

Please CC answers to me.

Yours, Florian.

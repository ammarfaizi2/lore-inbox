Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310519AbSCCDDh>; Sat, 2 Mar 2002 22:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSCCDD1>; Sat, 2 Mar 2002 22:03:27 -0500
Received: from nic-118-c60-41.mn.mediaone.net ([24.118.60.41]:1920 "EHLO
	nic-118-c60-41.mediaone.net") by vger.kernel.org with ESMTP
	id <S310503AbSCCDDG>; Sat, 2 Mar 2002 22:03:06 -0500
Date: Sat, 2 Mar 2002 21:02:57 -0600 (CST)
From: "Scott M. Hoffman" <scott1021@attbi.com>
X-X-Sender: scott@nic-118-c60-41.mediaone.net
Reply-To: scott1021@attbi.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, <shaggy@austin.ibm.com>
Subject: JFS on 2.4.19-pre2-ac1/2
Message-ID: <Pine.LNX.4.42.0203022041080.1308-100000@nic-118-c60-41.mediaone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Under pre2-ac1, untarring my /home backup to JFS had problems.  I was 
unable to switch virtual consoles for several seconds at a time.  Under 
ext3 the same kernel was fine.  The output of vmstat shows many more 
context switches for JFS than ext3, if that means anything.  If anyone's 
interested in any more info, please ask.
  Neither kernel produces any info under /proc/fs/jfs as per the config 
option CONFIG_JFS_STATISTICS.

Thanks,
Scott




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSLOOcg>; Sun, 15 Dec 2002 09:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLOOcg>; Sun, 15 Dec 2002 09:32:36 -0500
Received: from ping.ovh.net ([213.186.33.13]:1801 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id <S261615AbSLOOcf>;
	Sun, 15 Dec 2002 09:32:35 -0500
Date: Sun, 15 Dec 2002 15:40:50 +0100
From: Octave <oles@ovh.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: problem with Andrew's patch ext3
Message-ID: <20021215144050.GY12395@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

I patched 2.4.20 with your patch found out on http://lwn.net/Articles/17447/
and I have a big problem with:
once server is booted on 2.4.20 with your patch, when I want to reboot
with /sbin/reboot, server makes a Segmentation fault and it crashs.
I tested it on 50-60 servers and it is the same problem. I tested kernel
2.4.20 without your patch: no problem.

# uname -a 
Linux XXXXXX 2.4.20 #1 ven déc 13 17:21:23 CET 2002 i686 unknown
# /sbin/reboot

Broadcast message from root (pts/0) Sun Dec 15 14:26:03 2002...

The system is going down for reboot NOW !!
Segmentation fault
# 
# dmRead from remote host XXXXXXXX: Connection reset by peer

It is crashed.

no logs :/

Regards
Octave



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUDAPYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUDAPYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:24:55 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:53962 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262925AbUDAPYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:24:45 -0500
Subject: [ANNOUNCE] Umbrella-0.3 released
From: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>
To: umbrella-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1080829523.23663.40.camel@helene>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Apr 2004 16:25:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

After three weeks of development, we proudly present Umbrella version
0.3 for Linux 2.6.x kernels.


--- Short version ---
Umbrella for implements a combination of process based mandatory access
control (MAC) and authentication of files for Linux on top of the Linux
Security Modules framework. The MAC scheme is enforced by a set of
restrictions for each process.


--- What's new? ---
This release rounds up the implementation of process based restrictions.
To increase performance and to make the use of Umbrella even smoother
for programmers, restrictions have been devided into two levels.

Level 1 is a static set of restrictions, which is provided by The
Umbrella Team. At present these is aimed at protecting a Linux system on
a HP iPAQ. Level 2 is restrictions is purely defined by the programmer
and applies only to the process and sub-processes that the restricted
program spawns.

A short simple example of the use of this may be found in the user space
program in the Umbrella 0.3 release or directly in cvs at:
http://cvs.sourceforge.net/viewcvs.py/*checkout*/umbrella/umbrella-devel/userspace/src/umb_user.c?rev=1.3

Furthermore a hash table is implemented to increase flexibility and
speed of the lookup of restrictions.

More details is given on the Umbrella web site:
http://umbrella.sourceforge.net
and on the project site
http://www.sourceforge.net/projects/umbrella


--- Download Umbrella 0.3 ---
The Umbrella 0.3 kernel patch together with a user space example can be
directly downloaded here:
http://prdownloads.sourceforge.net/umbrella/umbrella-0.3.tar.bz2?download


--- Comments, Questions and Contributions ---
Comments, questions and contributions are most welcome! The development
team can be contacted on umbrella@cs.auc.dk or in the SourceForge
forums, found here: http://sourceforge.net/forum/?group_id=101217


Enjoy! c",)


The very best regards,

The Umbrella Team.


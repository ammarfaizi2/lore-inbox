Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbTCNWcK>; Fri, 14 Mar 2003 17:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261191AbTCNWcK>; Fri, 14 Mar 2003 17:32:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22732 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261165AbTCNWcJ>; Fri, 14 Mar 2003 17:32:09 -0500
Subject: Updated ext3 patch set for 2.4
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3 users list <ext3-users@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@digeo.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047681775.2566.664.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 14 Mar 2003 22:42:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've pushed my current set of ext3 diffs (against Marcelo's current
tree) to

http://people.redhat.com/sct/patches/ext3-2.4/dev-20030314/

This includes:

00-merged/			diffs recently merged into 2.4
10-core-fixes-other/		misc fixes/tweaks from akpm, adilger
11-core-fixes-sct/		misc fixes/tweaks from sct
20-tytso-updates/		Ted's recent updates
21-updates-sct/			recent sct diffs pending upstream merge
40-iflush-sct/			experimental inode-flush code
50-debug/			archive of debug patches
99-deferred/			stuff being kept around for future consideration

plus

all-patches.tar.gz		tarball of the above
combo-patch-10to21.patch.gz	combo patch of the 10--21 dirs above

The tytso-updates includes all of Ted's recent changes, separated out as
incrementals against the first htree+orlov changes he posted a while
back, so that we can keep track of diffs.  It includes his back-port of
akpm's orlov changes, plus the recent htree and noatime fixes.  Oh, and
it has the requested "+htree+orlov" ext3 version string added.

The combo patch should be equivalent to Ted's latest set of htree+orlov
diffs (except containing a few extra fixes that I'll start pushing
upstream next week), but broken out in a way that makes it easier to
track the individual change history.  It has had only minimal testing so
far.

Cheers,
 Stephen


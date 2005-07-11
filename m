Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVGKRSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVGKRSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVGKRRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:17:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62417 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261230AbVGKRRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:17:08 -0400
Date: Mon, 11 Jul 2005 18:17:03 +0100 (BST)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: GIT problems.
Message-ID: <Pine.LNX.4.56.0507111758300.15333@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm having trouble merging my local branch to the latest tree from linus.
I event tried to grab a fresh tree from kernel.org and then create a clone 
from it.

I did a 

cg-init 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

This worked with output being

sent 147 bytes  received 863 bytes  673.33 bytes/sec
total size is 41  speedup is 0.04

receiving file list ... done
progress: 2139 objects, 6243714 bytes, 100% done
pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.idx
pack/pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack

sent 47219 bytes  received 73840482 bytes  304691.55 bytes/sec
total size is 73625377  speedup is 1.00

receiving file list ... done
v2.6.11
v2.6.11-tree
v2.6.12
v2.6.12-rc2
v2.6.12-rc3
v2.6.12-rc4
v2.6.12-rc5
v2.6.12-rc6
v2.6.13-rc1
v2.6.13-rc2

sent 339 bytes  received 1789 bytes  4256.00 bytes/sec
total size is 410  speedup is 0.19
Missing object of tag v2.6.11... different source (obsolete tag?)
Missing object of tag v2.6.11-tree... different source (obsolete tag?)
Missing object of tag v2.6.12... different source (obsolete tag?)
Missing object of tag v2.6.12-rc2... different source (obsolete tag?)
Missing object of tag v2.6.12-rc3... different source (obsolete tag?)
Missing object of tag v2.6.12-rc4... different source (obsolete tag?)
Missing object of tag v2.6.12-rc5... different source (obsolete tag?)
Missing object of tag v2.6.12-rc6... different source (obsolete tag?)
Missing object of tag v2.6.13-rc1... different source (obsolete tag?)
Missing object of tag v2.6.13-rc2... different source (obsolete tag?)
New branch: 5c23804a0941a111752fdacefe0bea2db1b4d93f
Cloned (origin 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
available as branch "origin")


Next I did the below.

mkdir fbdev-2.6
cd fbdev-2.6
cg-init /usr/src/linus-2.6/

defaulting to local storage area
`/usr/src/linus-2.6//.git/refs/heads/master' -> `.git/refs/heads/origin'
progress: 2 objects, 896 bytes
does not exist 
/usr/src/linus-2.6//.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166
Cannot obtain needed blob 2a7e338ec2fc6aac461a11fe8049799e65639166
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed

What is wrong?



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUKVL0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUKVL0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUKVL0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:26:40 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:40681 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262063AbUKVLZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:25:23 -0500
Subject: Problem with linux-2.6 BK repository on BKbkits?
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Mon, 22 Nov 2004 11:25:08 +0000
Message-Id: <1101122708.18623.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just did a bk pull from bk://linux.bkbits.net/linux-2.6 and it seems to
have worked fine but I noticed the following error message:

[snip]
Applying   1 revisions to net/ipv4/netfilter/ipt_CLUSTERIP.c
fk cache: insert error for johnrose@austin.ibm.com[greg]|
drivers/pci/hotplug/rpaphp_pci.c|20210428163018
insert: File exists
Applying   1 revisions to drivers/pci/hotplug/rpaphp_pci.c
[snip]

I don't know what that means and whether it is a problem but I thought I
would mention it as I have never seen it before...

bk -r check doesn't report any problems after the pull and another bk
pull reports nothing to pull.

$ bk version
BitKeeper/Free version is bk-3.2.3 20040818155841 for x86-glibc23-linux
Built by: lm@redhat9.bitmover.com in /build/3.2.x-lm/src
Built on: Wed Aug 18 11:18:31 PDT 2004
Running on: Linux 2.6.8-24.3-smp

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/


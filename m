Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTIRViX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 17:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTIRViX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 17:38:23 -0400
Received: from smtp2.brturbo.com ([200.199.201.158]:43401 "EHLO
	smtp2.brturbo.com") by vger.kernel.org with ESMTP id S262116AbTIRViW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 17:38:22 -0400
From: Guilherme Polo <gpolo@nl.linux.org>
Reply-To: gpolo@nl.linux.org
Organization: Effort Linux
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: XFS internal error - kernel 2.4.22
Date: Thu, 18 Sep 2003 18:36:57 -0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309181836.57847.gpolo@nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, today I was doing rm -rf on some old kernel trees on a partition that 
uses xfs and I got this message:
-------------------------
XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1596 of file xfs_alloc.c.  
Caller 0xc017c066
c3645d7c c01a63b8 00000000 00013aec cc1b9cf0 c017b383 c02c26aa 00000001
       00000000 c02c2684 0000063c c017c066 00000000 00013aec cc1b9cf0 00000000
       d6341400 00000000 caf8c0c0 d6341400 00000000 00000001 00013aeb 0001fb3a
Call Trace: [<c01a63b8>]  [<c017b383>]  [<c017c066>]  [<c017c066>]  
[<c018b783>]  [<c01ae6ba>]  [<c01c683d>]  [<c01d6f97>]  [<c01d5de0>]  
[<c0146c5b>]  [<c01474e6>]  [<c014595c>]  [<c013eadc>]  [<c013eba9>]  
[<c0108813>]
xfs_force_shutdown(ide0(3,3),0x8) called from line 4051 of file xfs_bmap.c.  
Return address = 0xc01d694a
Filesystem "ide0(3,3)": Corruption of in-memory data detected.  Shutting down 
filesystem: ide0(3,3)
Please umount the filesystem, and rectify the problem(s)
-------------------------

Im using linux 2.4.22 with xfs for i386
Hmm... I dont know what more to include here (first time posting a problem 
here)


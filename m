Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTEINnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTEINnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:43:04 -0400
Received: from [203.124.139.208] ([203.124.139.208]:43460 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id S263183AbTEINnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:43:03 -0400
Message-ID: <00b401c31632$d19b7d30$f1bba5cc@pc5579>
From: "Chandan S Pansare \(pcsbom\)" <chandan.pansare@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel enhancement for stale NFS file handle?
Date: Fri, 9 May 2003 19:26:11 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to configure Veritas Cluster server on RHAS2.1 (2 node
configuration).  Every thing works fine till I configure NFS service group.
Once the service is up I am able to mount exported FS on my client machine.
But once I switch over the service from one node to another, I get *stale
NFS file handle*  error for any open file (eg while doing dd if=/dev/zero
of=<mntd_FS>/<file> I get stale handle for <file>) but I am able to do any
new operation like ls, cd or dd without any need for unmounting/mounting the
FS.
This requires some kernel enhancement and is implemented in RHAS2.1 (kernel
2.4.9-e.3) but still I am facing this problem.
I had same trouble with RED HAT CLUSTER MANAGER but somehow it got resolved.
[ and I am not sure how :-( ]
Any idea how this can be resolved??

Regards
Chandan


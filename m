Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbTEMWDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTEMWDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:03:22 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:38045 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261207AbTEMWDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:03:11 -0400
Date: Tue, 13 May 2003 15:14:36 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: 2.5.69-mm4 fails to boot
Message-ID: <20030513221435.GI32128@ca-server1.us.oracle.com>
Mail-Followup-To: akpm@digeo.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	2.5.69-mm4 is failing to boot.  It completes init_rootfs() in
mnt_init() but does not complete init_mount_tree().  Call me dumb, but
nothing obvious jumps out at me, I don't see any diff(1) from -mm3, and
I don't really have time to actively debug it.  I can indeed build and
try kernels.
	This is the WimMark box.  Compaq ML570.  4x700MHz Xeon, 2GB RAM.
Still boots all the other kernels fine.

Joel

-- 

"Maybe the time has drawn the faces I recall.
 But things in this life change very slowly,
 If they ever change at all."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

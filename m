Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269656AbUHZVOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269656AbUHZVOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269651AbUHZVLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:11:55 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11668 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269662AbUHZVIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:08:21 -0400
From: jmerkey@comcast.net
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Date: Thu, 26 Aug 2004 21:08:19 +0000
Message-Id: <082620042108.24853.412E5143000405FF000061152200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> You're years late to this game. It's been thought about and the
> consensus (which I disagreed with) was to reject virtualspace pressure
> related changes of this kind for 32-bit platforms in favor of refusing
> to support 32-bit platforms and/or workloads requiring them.
> 

This has nothing to do with only having 1GB of kernel address 
space and not enough virtual space to load a large swath of drivers
or support modules loading reentrantly.  It's a little difficult to quantify
 how much kernel address space will be needed when you don't
know if a full configuration will fit into it.  The fact people use this 
patch at all is **EVIDENCE THAT THERE ALREADY IS A PROBLEM**
with limiting kernel address space to 1GB.  And who the hell cares about 
a mouldy, antiquated ABI spec modeled after 1970 Unix technology anyway?  It 
should be another option for executable formats.   All this ABI compatibility huey 
is some Intel/SCO pipe dream for supporting applications across multiple Unix 
platforms anyway.  If it doesn't run on Linux, who the hell cares?

:-)

Jeff

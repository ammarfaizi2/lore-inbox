Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVLPUzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVLPUzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 15:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVLPUzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 15:55:38 -0500
Received: from solarneutrino.net ([66.199.224.43]:53510 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932407AbVLPUzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 15:55:38 -0500
Date: Fri, 16 Dec 2005 15:55:36 -0500
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: lockd: couldn't create RPC handle for (host)
Message-ID: <20051216205536.GA20497@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, nfs locking stopped working on my file server running 2.6.15-rc5
today.  All clients that try locking operations hang, and I get the
message from the server:

lockd: couldn't create RPC handle for w.x.y.z

Also, the lockd process is unkillable, it looks like I'll have to
reboot.

The nfs mounts look like:

rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock

I've recently posted the kernel .config and dmesg for both the server
and clients for other bug reports.  For the server:

Message-ID: <20051129200013.GB6326@tau.solarneutrino.net>

and the clients:

Message-ID: <20051208022624.GA12944@tau.solarneutrino.net>

Any help would be appreciated.

Thanks,
-ryan

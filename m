Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269341AbUJRAAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269341AbUJRAAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 20:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269342AbUJRAAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 20:00:16 -0400
Received: from main.gmane.org ([80.91.229.2]:44177 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269341AbUJRAAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 20:00:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: NMI watchdog detected lockup
Date: Mon, 18 Oct 2004 00:00:03 +0000 (UTC)
Message-ID: <ckv123$pcs$1@sea.gmane.org>
References: <4172F91D.8090109@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ivry-1-81-57-179-18.fbx.proxad.net
User-Agent: slrn/0.9.8.0pl1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-17, Randy.Dunlap <rddunlap@osdl.org> wrote:
| 
|  I'm seeing this often during a kernel build on AIC79xx.
|  I did one kernel build on SATA without seeing this.
|  This is on a dual-Opteron IBM Workstation A with
|  2 GB RAM, SATA, & SCSI.
|  [...]
|  NMI Watchdog detected LOCKUP on CPU0, registers:
|  [...]

You are not the first one to observe frequent watchdog timeout
lockup on dual Opteron systems during intense I/O operations,
see this thread:

  http://thread.gmane.org/gmane.linux.ide/1933

Note: this does *not* seem to be SATA-related.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.


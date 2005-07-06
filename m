Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVGFXCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVGFXCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVGFW7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:59:42 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:15845 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261718AbVGFW63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:58:29 -0400
Date: Wed, 6 Jul 2005 15:58:23 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: Re: audit function doc. question
Message-Id: <20050706155823.233b103d.rdunlap@xenotime.net>
In-Reply-To: <20050706222115.GJ9153@shell0.pdx.osdl.net>
References: <20050706115904.43a95978.rdunlap@xenotime.net>
	<20050706222115.GJ9153@shell0.pdx.osdl.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005 15:21:15 -0700 Chris Wright wrote:

| * randy_dunlap (rdunlap@xenotime.net) wrote:
| > kernel/audit.c (2.6.13-rc1-git5) audit_log_start() says:
| > 
| > /* Obtain an audit buffer.  This routine does locking to obtain the
| >  * audit buffer, but then no locking is required for calls to
| >  * audit_log_*format.  If the tsk is a task that is currently in a
| >  * syscall, then the syscall is marked as auditable and an audit record
| >  * will be written at syscall exit.  If there is no associated task, tsk
| >  * should be NULL. */
| > struct audit_buffer *audit_log_start(struct audit_context *ctx, int type)
| > {
| > 
| > What does <tsk> refer to in the function description?
| > There is no <tsk> in this function.
| 
| It refers to tsk, tsk, stale comment.  It's task->audit_context (which is
| ctx there).  Interested in preparing a patch, could even move to proper
| kerneldoc format ;-)

Yes, that's why I asked, I'm adding kerneldoc format comments
to audit*.c (2 files).  You'll see it soon.

---
~Randy

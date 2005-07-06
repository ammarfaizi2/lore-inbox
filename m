Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVGFVy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVGFVy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVGFUKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:10:06 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:29651 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261792AbVGFS7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:59:14 -0400
Date: Wed, 6 Jul 2005 11:59:04 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-audit@redhat.com
Subject: audit function doc. question
Message-Id: <20050706115904.43a95978.rdunlap@xenotime.net>
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

kernel/audit.c (2.6.13-rc1-git5) audit_log_start() says:

/* Obtain an audit buffer.  This routine does locking to obtain the
 * audit buffer, but then no locking is required for calls to
 * audit_log_*format.  If the tsk is a task that is currently in a
 * syscall, then the syscall is marked as auditable and an audit record
 * will be written at syscall exit.  If there is no associated task, tsk
 * should be NULL. */
struct audit_buffer *audit_log_start(struct audit_context *ctx, int type)
{


What does <tsk> refer to in the function description?
There is no <tsk> in this function.

Thanks,
---
~Randy

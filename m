Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVANUtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVANUtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVANUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:49:22 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:22987 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S262117AbVANUtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:49:13 -0500
Subject: Adding a new system call from a module in 2.6
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 14 Jan 2005 15:49:20 -0500
Message-Id: <1105735760.3253.23.camel@avishay.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the sys_call_table is no longer exported, what would be the
best way to add a new system call from a module in 2.6?  I have only
seen the system call table in assembly code (such as in
arch/i386/kernel/entry.S) and do not know how to export it.  I know that
doing this is not recommended, but it would save me a lot of time while
developing new system calls (no need to recompile kernel and reboot for
every change).  Thanks in advance for any suggestions.

Avishay Traeger



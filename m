Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUIQJa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUIQJa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268641AbUIQJa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:30:26 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:42529 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S268633AbUIQJaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:30:25 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC]: block ptrace operations.
Reply-To: James Cownie <jcownie@etnus.com>
X-Mailer: MH-E 7.4.3; nmh 1.1-RC1; GNU Emacs 21.3.1
Date: Fri, 17 Sep 2004 10:30:24 +0100
From: James Cownie <jcownie@etnus.com>
Message-Id: <20040917093024.0FAFF1DA71@amd64.cownie.net>
X-OriginalArrivalTime: 17 Sep 2004 09:30:49.0508 (UTC) FILETIME=[04A52E40:01C49C99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any reason why the kernel does not in general support the block
ptrace operations (PTRACE_READDAATA, PTRACE_READTEXT, PTRACE_WRITEDATA,
PTRACE_WRITEEXT) ?

The major part of the code for implementing them is in the architecture
independent part of the kernel (kernel/ptrace.c ptrace_readdata(...),
ptrace_wrietdata(...)), yet the only platform which supports them as of
2.6.8.1 appears to be the SPARC.

Would patches to implement them on more platforms be likely to be
accepted ?

It seems weird to me that they're not already supported on more
platforms since they're compiling in most of the code they need !

-- 
-- Jim
--
James Cownie	<jcownie@etnus.com>
Etnus, LLC.     +44 117 9071438
http://www.etnus.com


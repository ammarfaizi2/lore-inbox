Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbUBCPgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUBCPgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:36:42 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:52233 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265391AbUBCPgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:36:41 -0500
Subject: Re: 2.6.2-rc3-mm1 (i_sem)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1075822589.2341.2.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Tue, 03 Feb 2004 16:36:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another i_sem warning:

i_size_write() called without i_sem
Call Trace:
 [<c013915d>] i_size_write_check+0x5b/0x5d
 [<c0188dbc>] ext3_journalled_commit_write+0x11d/0x159
 [<c0185cb6>] commit_write_fn+0x0/0x73
 [<c016123e>] page_symlink+0xab/0x18d
 [<c018c466>] ext3_symlink+0x145/0x185
 [<c018c321>] ext3_symlink+0x0/0x185
 [<c01601c2>] vfs_symlink+0x74/0xa8
 [<c01602c9>] sys_symlink+0xd3/0xdf
 [<c010b671>] do_IRQ+0x154/0x19d
 [<c0314fc6>] sysenter_past_esp+0x43/0x65




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUDOPYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbUDOPYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:24:46 -0400
Received: from mail.cyclades.com ([64.186.161.6]:46786 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263633AbUDOPYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:24:44 -0400
Date: Wed, 14 Apr 2004 09:49:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-rc4
Message-ID: <20040414124953.GB1406@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

This is the v2.4.26 release candidate.

It contains a few important fixes, one fixing a memory leak in the fork() 
path and another fixing a exploitable ISO9660 symlink buffer overflow.

For those who use mainline kernels, upgrade is recommended.

v2.4.26 will be released shortly as -rc4.


Summary of changes from v2.4.26-rc3 to v2.4.26-rc4
============================================

<john.l.byrne:hp.com>:
  o do_fork() error path memory leak

Ernie Petrides:
  o fix potential iso9660 symlink overflow

Marcelo Tosatti:
  o Nathan Scott: Export the PPC vmalloc_start and ioremap_bot symbols for modules using VMALLOC_START and VMALLOC_END (XFS uses these, for example)
  o Changed EXTRAVERSION to -rc4



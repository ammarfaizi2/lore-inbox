Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTGASap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTGASap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:30:45 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:4234 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263187AbTGASao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:30:44 -0400
Date: Tue, 1 Jul 2003 20:43:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 2.5.73 take 2: description.
Message-ID: <20030701184359.GA12212@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
another 6 patches for s390.

Short descriptions:
1) Fix SEMTIMEDOP in sys_ipc. The corresponding glibc wrapper is already
   in the official cvs. Patch by Ernie Petrides.
2) Fix ptrace system call number replacement code.
3) Fix online attribute, the values for enabling/disabling a device are
   the other way round.
4) Add support for different processor types. Add new path group algorithm
   and new relocation types introduces with the latest machine (z990).
5) Add thin interrupt support to qdio. Required for qeth.

6) New driver: the qeth network driver. The patch is big (368K), too big
   for the mailing-list. This patch won't appear on linux-kernel, if someone
   else need a copy either wait in the hope that it will get integrated soon
   or sent me a mail.

Patches are against linux-bk as of 2003/07/01.

blue skies,
  Martin.


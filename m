Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVAUTPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVAUTPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVAUTPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:15:06 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:39655 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262482AbVAUTLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:11:24 -0500
Date: Fri, 21 Jan 2005 11:11:24 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200501211911.j0LJBOtm029047@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [ia64] compile error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just pulled.

In file included from arch/ia64/mm/discontig.c:23:
include/linux/nodemask.h: In function `__first_unset_node':
include/linux/nodemask.h:246: warning: passing arg 1 of `__find_next_zero_bit' discards qualifiers from pointer target type
arch/ia64/mm/discontig.c: In function `find_pernode_space':
arch/ia64/mm/discontig.c:389: error: `__per_cpu_offset' undeclared (first use in this function)
arch/ia64/mm/discontig.c:389: error: (Each undeclared identifier is reported only once
arch/ia64/mm/discontig.c:389: error: for each function it appears in.)
arch/ia64/mm/discontig.c:548:24: macro "per_cpu_init" passed 1 arguments, but takes just 0
arch/ia64/mm/discontig.c: At top level:
arch/ia64/mm/discontig.c:549: error: syntax error before '{' token

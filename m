Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTJAO5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTJAO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:57:45 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:21386 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262273AbTJAO50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:57:26 -0400
Subject: 2.6.0-test6: Oops at 'sysexit' on all threads after APM resume.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1065020242.21551.285.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Wed, 01 Oct 2003 15:57:23 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

general protection fault: 0000 [#11]
CPU:	0
EIP:	0060:[<c010b3f5>]	Not tainted
EFLAGS:	00010246
EIP is at sysenter_past_esp+0x6e/0x71
eax: 00000001   ebx: 00000000    ecx: bffffd78   edx: ffffe410
esi: 0804b280   edi: bffffdab    ebp: d6056000   esp: d6057fc4


0xc010b3f5 <sysenter_past_esp+110>:     sysexit


-- 
dwmw2


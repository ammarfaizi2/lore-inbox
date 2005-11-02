Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVKBRoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVKBRoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVKBRoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:44:18 -0500
Received: from neo.relay-host.net ([216.177.17.40]:17819 "HELO
	neo.relay-host.net") by vger.kernel.org with SMTP id S965146AbVKBRoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:44:17 -0500
Date: 2 Nov 2005 17:50:22 -0000
Message-ID: <20051102175022.13637.qmail@neo.relay-host.net>
From: listmonkey@neo.relay-host.net
To: linux-kernel@vger.kernel.org
Subject: SMP CPU affinity questions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

I am trying to use a quad Opteron motherboard with SMP Kernel 2.6.5 for a quasi-real-time task.
I need to assign all processes to specific CPUs, including interrupt handlers.
I have had success using sched_setaffinity() to set the CPU for processes I create, but I am unable,
as root, to force system processes to move to another CPU.  Any ideas?

I can find no documentation about how to force an interrupt handler to a specific CPU - is this
possible without modifying the kernel?


--Pete

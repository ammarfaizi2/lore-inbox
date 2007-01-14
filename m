Return-Path: <linux-kernel-owner+w=401wt.eu-S1751141AbXANHfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXANHfe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXANHfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:35:34 -0500
Received: from www.osadl.org ([213.239.205.134]:57889 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751141AbXANHfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:35:34 -0500
Message-Id: <20070114081905.135797900@inhelltoy.tec.linutronix.de>
User-Agent: quilt/0.46-1
Date: Sun, 14 Jan 2007 08:33:44 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 0/3] Scheduled removal of SA_xxx interrupt flags 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

the following series removes the deprecated SA_xx interrupt flags as scheduled.
There are some new users of those flags since the initial cleanup patch. The
fixup of those users is split into two parts:
 1) mainline fixups
 2) -mm fixups

    tglx

-- 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUE1LOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUE1LOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 07:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUE1LOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 07:14:06 -0400
Received: from math.ut.ee ([193.40.5.125]:4529 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261239AbUE1LOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:14:00 -0400
Date: Fri, 28 May 2004 14:13:57 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: No timer interrupts shown on PPC32?
Message-ID: <Pine.GSO.4.44.0405281411340.12976-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was watching vmstat output on my PPC (Motorola Powerstack II Pro4000,
PReP, OF, no residual data) and noticed that vmstat show almost no
interrupts. This is because there is no timer interrupt registered in
/proc/interrupts. Is this a known "feature" or just a forgotten thing?

I'm running 2.4.27-pre2.

-- 
Meelis Roos (mroos@linux.ee)


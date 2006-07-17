Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWGQQxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWGQQxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWGQQxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:53:17 -0400
Received: from port-83-236-173-99.static.qsc.de ([83.236.173.99]:63941 "EHLO
	isl.de") by vger.kernel.org with ESMTP id S1751066AbWGQQxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:53:16 -0400
Message-ID: <44BBC09D.5060409@isl.de>
Date: Mon, 17 Jul 2006 18:53:49 +0200
From: Andreas Rieke <andreas.rieke@isl.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel memory leak?
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after booting a machine, it runs well using about 300 M of 1 G physical
RAM. However, the remaining RAM decreases day by day, and after 2 or 3
weeks, the machine crashes because swapping takes too much time.
However, all processes together take about 250 MBytes according to ps,
thus I assume that the kernel takes the rest. free tells me in fact that
much swap space is used an nearly no physical RAM is left.

This behaviour has been seen on Red Hat Enterprise Linux 3 with a 2.4
kernel and on SuSE Linux 10 with a 2.6.13-15-default kernel. There are
no unusual things running on the machine, the main application is an
apache web server with a PostgreSQL database.

Is there any kernel support to detect where the memory has gone?
Is any kind of memory eating virus or worm known?
Is it possible that processes request memory which is NOT considered in
/proc or in the procps tools?
Is it possible that processes are invisible in /proc or in the procps tools?

Thanks in advance,

Andreas

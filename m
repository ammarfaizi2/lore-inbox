Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUCDH1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUCDH1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:27:12 -0500
Received: from math.ut.ee ([193.40.5.125]:6537 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261558AbUCDH1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:27:10 -0500
Date: Thu, 4 Mar 2004 09:27:06 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25: nosmp breaks ICH5 ide irq on S875WP1
Message-ID: <Pine.GSO.4.44.0403040923100.2398-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested 2.4.25 on Intel S875WP1 mainboard. Whren I run a normal SMP
kernel, it works fine. When I give it a "nosmp" boot option (an no other
special options), it fails to boot while detecting IDE devices. The IDE
is Intel ICH5 (ICH5-R?) on a 875P chipset. The hdd's are detected hde
and hdg normally. With "nosmp", it tells
hde: interrupt timeout
(or was it lost interrupt) and this repeats after some time.

So probably the IRQ routing is broken in nosmp. Is this normal somehow?

Have not tried UP kernel.

-- 
Meelis Roos (mroos@linux.ee)


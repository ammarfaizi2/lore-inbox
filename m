Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUFULWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUFULWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUFULWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:22:42 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:51614 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266195AbUFULWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:22:40 -0400
Subject: sungem - ifconfig eth0 mtu 1300 -> oops
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1087568322.4455.22.camel@localhost>
Mime-Version: 1.0
Date: Mon, 21 Jun 2004 13:21:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I have some ethernet connection and then do:

ifconfig eth0 mtu 1300

I get an immediate kernel panic (kernel 2.6.6) on a powerbook g4 15"
1ghz.

xmon trace (jpeg) is here: http://www.nn7.de/kernel/mtu1300.jpg  (use a
webbrowser to view it as it is a redirect)

this is 100% reproducable here so I hope it is more easy to fix.

Regards,
Soeren


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUE3P5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUE3P5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 11:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUE3P5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 11:57:24 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:26090 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262361AbUE3P5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 11:57:22 -0400
Date: Sun, 30 May 2004 08:57:15 -0700
From: Lee Howard <faxguy@howardsilvan.com>
To: c-d.hailfinger.kernel.2004@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc1 breaks forcedeth
Message-ID: <20040530155715.GA2612@bilbo.x101.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the forcedeth driver for my nVidia ethernet successfully with 
kernel 2.6.6.  I recently tested 2.6.7-rc1, and when using it the 
ethernet does not work, and I see this in dmesg:

eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out

I can ping localhost and the device's IP number, but I cannot ping 
other systems' IP numbers.

Thanks.

Lee.

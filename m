Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUJGSTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUJGSTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUJGSRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:17:36 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:27100 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267607AbUJGSPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:15:19 -0400
Subject: hang after resume with adb: starting probe task.
From: Soeren Sonnenburg <kernel@nn7.de>
To: linuxppc-dev@lists.linuxppc.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Oct 2004 20:14:55 +0200
Message-Id: <1097172895.3281.31.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of at least kernel version 2.6.9-rc2 I pretty often see the kernel
hang after returning from sleep mode hanging with the message "adb:
starting with probe task". This still happens with 2.6.9-rc3 but never
happened with 2.6.8.1.

Thats what is on the screen when it hangs (no more possible to enter
xmon):

http://fortknox.dyndns.org/pics/oopses/adb.jpg

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.


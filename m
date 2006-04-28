Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWD1Mys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWD1Mys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWD1Mys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:54:48 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36584 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1030378AbWD1Mys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:54:48 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17490.4240.578291.222262@alkaid.it.uu.se>
Date: Fri, 28 Apr 2006 14:54:40 +0200
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.17-rc3 broke FP exceptions on x86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running an FP exception using user-space application
(the runtime system for the Erlang programming language
in my case) on an Athlon64 with a 32-bit 2.6.17-rc3 kernel
quickly results in a complete system hang: mouse is dead,
keyboard is dead, the network doesn't reply to pings.
Had to reboot via the power switch to get the machine back.

This happended twice in a row. With 2.6.17-rc2 things
work fine like they always have before.

Just FYI. I'll try to debug this this weekend if noone
beats me to it.

/Mikael

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUBHWXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUBHWXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:23:14 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:16605 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S264233AbUBHWXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:23:13 -0500
From: Michael Frank <mhf@linuxmail.org>
To: werner@almesberger.net, Andrew Morton <akpm@osdl.org>
Subject: [patch] defer panic for too many items in boot parameter line
Date: Mon, 9 Feb 2004 06:23:04 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402090623.05965.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, nice, I like to defer a panic on zone init failure.

Perhaps we could combine the panic side and use panic_later.

Regards
Michael 


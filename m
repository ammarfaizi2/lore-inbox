Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUAJB5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 20:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUAJB5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 20:57:06 -0500
Received: from [218.93.20.101] ([218.93.20.101]:35505 "EHLO mail.shinco.com")
	by vger.kernel.org with ESMTP id S264414AbUAJB5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 20:57:04 -0500
Date: Sat, 10 Jan 2004 09:57:00 +0800
From: Peng Yong <ppyy@bentium.com>
To: linux-kernel@vger.kernel.org
Subject: system resource limit in kernel 2.6
Message-Id: <20040110095333.0765.PPYY@bentium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We upgrade one of our production http server, runing apache 1.3.29, to
kernel 2.6. some time the main process of apache exit and here is the
error log:

[Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
[Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
[Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
[Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
[Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534
[Sat Jan 10 08:48:44 2004] [alert] (11)Resource temporarily unavailable: setuid: unable to change to uid: 65534


how can i tuning the kernel and remove the system resource limit?

Regards,

Peng Yong

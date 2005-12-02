Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVLBS0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVLBS0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVLBS0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:26:45 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:28689 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750847AbVLBS0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:26:44 -0500
Date: Fri, 2 Dec 2005 19:28:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvards@osdl.org>,
       "Mauro Carvalho Chehab" <mchehab@brturbo.com.br>,
       LKML <linux-kernel@vger.kernel.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>
Subject: Incorrect v4l patch in 2.6.15-rc4-git1
Message-Id: <20051202192814.282fc10c.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please revert this commit:

author	Mauro Carvalho Chehab <mchehab@brturbo.com.br>
	Thu, 1 Dec 2005 08:51:35 +0000 (00:51 -0800)
committer	Linus Torvalds <torvalds@g5.osdl.org>
	Thu, 1 Dec 2005 23:48:57 +0000 (15:48 -0800)
commit	769e24382dd47434dfda681f360868c4acd8b6e2
tree	1be728dd2f1a7f523e3de5f3f39b97a4b9905dbe
parent	6f502b8a7858ecfa7d2a0762f7663b8b3d0808fc

[PATCH] V4L: Some funcions now static and I2C hw code for IR

- Some funcions are now declared as static
- Added a I2C code for InfraRed.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

I objected against this patch here :
http://lkml.org/lkml/2005/12/1/196

I would also seriously question the benefit of merging that kind of
patch at the -rc4 stage, even if it wasn't incorrect. It's not fixing
any actual problem, I can't see how it was supposed to belong there.

Thanks,
-- 
Jean Delvare

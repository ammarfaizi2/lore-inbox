Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280762AbRKGFPa>; Wed, 7 Nov 2001 00:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280774AbRKGFPV>; Wed, 7 Nov 2001 00:15:21 -0500
Received: from pivsbh2.ms.com ([199.89.64.104]:33444 "EHLO pivsbh2.ms.com")
	by vger.kernel.org with ESMTP id <S280762AbRKGFPB>;
	Wed, 7 Nov 2001 00:15:01 -0500
To: linux-kernel@vger.kernel.org
Subject: loopback device on 2.4.14
From: Hiroyuki ARAKI <hiro@zob.ne.jp>
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3
 =?iso-2022-jp?B?KBskQkt2RSYyVhsoQik=?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011107141458R.araki@ebid530.ms.com>
Date: Wed, 07 Nov 2001 14:14:58 +0900
X-Dispatcher: imput version 990905(IM130)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, dear maintainers,

I found a problem on 2.4.14 kernel's loop back device driver
that still contains 'deactivate_page' service calls
even if the service seems be removed on 2.4.14.
(drivers/block/loop.c)

Maybe it is enough simply removing them from loop.c
but I am afraid that it may cause any memory leak on the
system.

I hope that it will fixed in next release.

Thank you,
and I'm very sorry my broken strange English.
---
Hiroyuki Araki <hiro@zob.ne.jp>

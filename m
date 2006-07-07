Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWGGDoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWGGDoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWGGDoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:44:07 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:3743 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S1751171AbWGGDoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:44:06 -0400
Message-ID: <3306.58.105.227.226.1152244539.squirrel@58.105.227.226>
Date: Fri, 7 Jul 2006 13:55:39 +1000 (EST)
Subject: Module link
From: yh@bizmail.com.au
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all helps. The module can now be loaded. There are some other
issues as descripbled as follows:

1. The module I used links to i2c drivers. It works fine in kernel 2.4
after "insmod NewModule.o", but now it has a NULL point in kernel 2.6 when
to init it. It seems that the i2c driver is not linked in the module. How
can I link an i2c to my driver module?

2. In kernel 2.4, when I call "insmod NewModule.o", the insmod can find
the path of the NewModule.o and to init the module. In 2.6 kernel, the
"insmod NewModule.ko" does not know the path, so I have to specify the
path explicitly as "insmod
/lib/modules/2.6.8.1/kernel/drivers/char/NewModule.ko" to make it work. I
guess the above problem in question 1 may also related to this issue. What
did I wrong here?

Thank you.

Jim




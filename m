Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWIUVl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWIUVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWIUVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:41:56 -0400
Received: from smtp.ono.com ([62.42.230.12]:19798 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1751612AbWIUVlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:41:55 -0400
Date: Thu, 21 Sep 2006 23:41:51 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc7-mm1: no /dev/tty0
Message-ID: <20060921234151.2dd12d32@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.4.0cvs208 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

When booting 2.6.18-rc7-mm1, the initscripts complain about /dev/tty0 not
being present. Then the boot sequence blocks...:

Sep 21 23:23:57 werewolf init: open(/dev/console): No such file or directory
Sep 21 23:24:07 werewolf last message repeated 17 times
Sep 21 23:24:12 werewolf init: Id "3" respawning too fast: disabled for 5 minutes

(from syslog)

The same userspace boots fine with -rc6-mm2.

Any ideas ?

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam10 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT

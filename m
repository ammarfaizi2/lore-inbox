Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136838AbREJQ0G>; Thu, 10 May 2001 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136839AbREJQZ5>; Thu, 10 May 2001 12:25:57 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:50450 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S136838AbREJQZj>; Thu, 10 May 2001 12:25:39 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200105101625.f4AGPTh02433@xyzzy.clara.co.uk>
Subject: Detecting Red Hat builds ?
To: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2001 17:25:29 +0100 (BST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How can I determine if the build my device driver is being compiled under is
a standard kernel.org one or a Red Hat one ?

The problem is I have a driver that includes syncppp.h which in the releases
from kernel.org is in linux/drivers/net/wan/ up to and including 2.4.2 after
which it moves to linux/include/net/. Can cope with this easily enough with
a "#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,2)" but unfortunatly the
kernel source supplied with Red Hat 7.1 reports itself as 2.4.2 but already
has the syncppp changes from 2.4.3.

I was shown a trick to solve a similar problem under 2.2.x but the symbol
defined as a side effect of including one of the standard system headers
is no longer present :-(


-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk

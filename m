Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266827AbUGVHpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUGVHpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266829AbUGVHpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:45:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:57559 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266827AbUGVHpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:45:40 -0400
Date: Thu, 22 Jul 2004 09:45:39 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "lkml " <linux-kernel@vger.kernel.org>
Cc: kernel@mandrakesoft.com
MIME-Version: 1.0
Subject: New dev model (was [PATCH] delete devfs)  
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <18541.1090482339@www50.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
sorry for the scrumbled reply as i'm not
subscribed to the list.

Mandrake is using devfs as default way to manage
devices ever since it included the 2.4.0-test kernels
and is currently near freeze for the next release 10.1
which will be probably based on 2.6.8 kernel still using
devfs. 
The current state of udev in Mandrake is pretty useless, 
none made attempts to integrate udev as replacement 
of devfs. Yes there is a binary package of udev,
but technically it's as if it's missing. udev
is mostly working, but ....
the entire distro is not aware of it existence
udev is not supported by init scripts, mkinitrd
the distro's tools for configuration

if you really decide to drop devfs so soon,
i guess the only choice for the next Mandrake release
would be to revert the patch or stay with an older kernel

best,

svetljo

-- 
+++ GMX DSL-Tarife 3 Monate gratis* +++ Nur bis 25.7.2004 +++
Bis 24.000 MB oder 300 Freistunden inkl. http://www.gmx.net/de/go/dsl


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbTIKIoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbTIKIoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:44:09 -0400
Received: from ad96e1d52.dsl.de.colt.net ([217.110.29.82]:34877 "EHLO
	argon.intranet.online-skating.de") by vger.kernel.org with ESMTP
	id S261165AbTIKIoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:44:07 -0400
Date: Thu, 11 Sep 2003 10:44:00 +0200
From: Harry Brueckner <hb@o-d.de>
Reply-To: Harry Brueckner <hb@o-d.de>
To: linux-kernel@vger.kernel.org
Subject: devfs with 2.6.0-test4 kernel
Message-ID: <196810000.1063269840@localhost.localdomain>
X-Mailer: Mulberry/3.1.0b6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just switched to a self compiled 2.6.0-test4 kernel with devfs support on 
my Debian unstable system. devfsd is running nicely without any complaints.
On my old 2.4.20 kernel I did not use devfs.

Now when I boot into the new 2.6 kernel it starts up but throws tons of 
messages like

...
FATAL: Module /dev/ttyx0
FATAL: Module /dev/ttyx1
FATAL: Module /dev/ttyx2
FATAL: Module /dev/ttyx3
FATAL: Module /dev/ttyx4
FATAL: Module /dev/ttyx5
...

and it seems not to find alot of other /dev entries as well.

Googling around I did not find any hints about where this problem might 
come from.

Any ideas what might be wrong?

TIA, Harry


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269895AbTGOX5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269906AbTGOX5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:57:25 -0400
Received: from smtp.terra.es ([213.4.129.129]:57665 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S269895AbTGOX5X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:57:23 -0400
Date: Wed, 16 Jul 2003 02:12:10 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Piet Delaney <piet@www.piet.net>
Cc: rddunlap@osdl.org, fsanchez@mail.usfq.edu.ec, linux-kernel@vger.kernel.org
Subject: Re: modules problems with 2.6.0 (module-init-tools-0.9.12)
Message-Id: <20030716021210.56ea8360.diegocg@teleline.es>
In-Reply-To: <1058313192.21300.988.camel@www.piet.net>
References: <3F147B8F.5000103@mail.usfq.edu.ec>
	<20030715152257.614d628b.rddunlap@osdl.org>
	<1058313192.21300.988.camel@www.piet.net>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El 15 Jul 2003 16:53:12 -0700 Piet Delaney <piet@www.piet.net> escribió:

> On Tue, 2003-07-15 at 15:22, Randy.Dunlap wrote:
> 
> I heard that if you install the new module-init-tools package in
> /sbin that you would be able to boot old kernels. Is that true?

It works here.
i've a debian distro, i apt-get'ed module-init-tools. Man modprobe says:

BACKWARDS COMPATIBILITY
       This version of insmod is  for  kernels  2.5.48  and  above.   If  it
       detects  a kernel with support for old-style modules (for which much of
       the work was done in userspace), it will attempt to run  insmod.modu-
       tils in its place, so it is completely transparent to the user.

diego@estel:~$ ls -l /sbin/insmod*
-rwxr-xr-x    1 root     root         5072 2003-06-15 12:27 /sbin/insmod
-rwxr-xr-x    1 root     root          359 2003-03-06 15:50 /sbin/insmod_ksymoops_clean
-rwxr-xr-x    1 root     root        95372 2003-03-06 15:50 /sbin/insmod.modutils


Looking at the size, insmod.modutils seems the 2.4 insmod loader. 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266337AbUGJS3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUGJS3q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUGJS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:29:46 -0400
Received: from smtp.terra.es ([213.4.129.129]:2809 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S266337AbUGJS3p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:29:45 -0400
Date: Sat, 10 Jul 2004 20:29:49 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.7-mm7
Message-Id: <20040710202949.2a72e822.diegocg@teleline.es>
In-Reply-To: <20040708235025.5f8436b7.akpm@osdl.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 8 Jul 2004 23:50:25 -0700 Andrew Morton <akpm@osdl.org> escribió:

> - Added a big UML update.   Needs work.

Fails to compile here (gcc (GCC) 3.3.4 (Debian 1:3.3.4-3) and
config "ARCH=um make defconfig")

  CC      arch/um/drivers/stdio_console.o
arch/um/drivers/stdio_console.c:207: error: conflicting types for `console_device'
include/linux/console.h:107: error: previous declaration of `console_device'
make[1]: *** [arch/um/drivers/stdio_console.o] Error 1

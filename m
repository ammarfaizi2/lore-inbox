Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbSJASqo>; Tue, 1 Oct 2002 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262228AbSJASqo>; Tue, 1 Oct 2002 14:46:44 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:41664 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP
	id <S261380AbSJASqn>; Tue, 1 Oct 2002 14:46:43 -0400
From: "immortal1015" <immortal1015@hotpop.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: compiling errors
X-mailer: Foxmail 4.2 [cn]
Date: Wed, 2 Oct 2002 2:53:26 +0800
Message-Id: <20021001185127.AA2C21B85AA@smtp-2.hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile the very simple kernel module code as following.
I compile this code using gcc -c hello.c, but gcc tell me:
 /usr/include/linux	/module.h:60 parse error before 'atomic_t'

What is the error? My gcc version is 2.96 and Redhat Linux 7.3


//////////////////////////////////////////////////////////////////////////////
#ifndef __KERNEL__
#  define __KERNEL__
#endif
#ifndef MODULE
#  define MODULE
#endif
#include <linux/version.h>
#include <linux/config.h>
#include <linux/module.h>

#include <linux/kernel.h> /* printk */

int init_module(void)
{
	printk("<1>Hello the world\n");
	return 0;
}

void cleanup_module(void)
{
	printk("<1>Goodbye the world\n");	
}
/////////////////////////////////////////////////////////////////


Best regards
yours Brucie




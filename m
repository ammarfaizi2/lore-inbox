Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293540AbSCGHYG>; Thu, 7 Mar 2002 02:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293539AbSCGHX6>; Thu, 7 Mar 2002 02:23:58 -0500
Received: from web13406.mail.yahoo.com ([216.136.175.64]:1553 "HELO
	web13406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293538AbSCGHXr>; Thu, 7 Mar 2002 02:23:47 -0500
Message-ID: <20020307072346.42694.qmail@web13406.mail.yahoo.com>
Date: Wed, 6 Mar 2002 23:23:46 -0800 (PST)
From: alal <alal_91801@yahoo.com>
Subject: mkdep.c error under Mandrake8.1-2.4.8
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm a newbie on Linux and just try to setup my Viking
56K PCI modem under Mandrake8.1(kernel-2.4.8-26mdk). 

I downloaded kernel source files(linux-2.4.8.tar.gz)
two days ago from www.kernel.org and installed it
under '/usr/src' to construct the '/usr/src/linux '
directory.

I applied 'make menuconfig' under '/usr/src/linux '
since the kernel configuration file is under '/boot' 

Then after 'make dep', I got following error msg,

"..
scripts/mkdep.c In function 'add_path'
..
scripts/mkdep.c:221 'PATH_MAX' undeclared(first use in
this function)
..
scripts/mkdep.c:221 size of array 'resolved_path' has
non-interger type
.."

The mkdep.c is under /usr/src/linux/scripts,  13.2kb
I think the problem might be, at the line 221, the
program uses "PATH_MAX" without definition. 

I know little about C++ and Linux, so could someone
tell me how to resovle this problem?

Thanks,

alal

__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/

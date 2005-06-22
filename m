Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVFVPlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVFVPlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFVPbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:31:38 -0400
Received: from adsl-68-248-203-41.dsl.milwwi.ameritech.net ([68.248.203.41]:42171
	"EHLO eagle.netwrx1.com") by vger.kernel.org with ESMTP
	id S261526AbVFVP20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:28:26 -0400
Date: Wed, 22 Jun 2005 10:28:25 -0500 (CDT)
From: George Kasica <georgek@netwrx1.com>
To: linux-kernel@vger.kernel.org
Subject: Problem compiling 2.6.12
Message-ID: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

Trying to compile 2.6.12 here and am getting the following error. I am 
currently running 2.4.31 and have upgraded the needed bits per the Change 
document before trying the build:

[root@eagle src]# cd linux
[root@eagle linux]# make mrproper
   CLEAN   .config
[root@eagle linux]# cp ../config-2.4.31 .config
[root@eagle linux]# make oldconfig
   HOSTCC  scripts/basic/fixdep
In file included from /usr/local/include/netinet/in.h:212,
                  from /usr/local/include/arpa/inet.h:23,
                  from scripts/basic/fixdep.c:115:
/usr/local/include/bits/socket.h:304: asm/socket.h: No such file or 
directory
make[1]: *** [scripts/basic/fixdep] Error 1
make: *** [scripts_basic] Error 2

Any help is appreciated, 2.4.31 will compile just fine and I am trying 
make oldconfig with 2.6.12

George
georgek@netwrx1.com

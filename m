Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUANJxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbUANJvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:51:23 -0500
Received: from 81-223-104-78.krugerstrasse.Xdsl-line.inode.at ([81.223.104.78]:10403
	"EHLO mail.sk-tech.net") by vger.kernel.org with ESMTP
	id S266105AbUANJur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:50:47 -0500
Date: Wed, 14 Jan 2004 11:00:00 +0100 (CET)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: linux-kernel@vger.kernel.org
Subject: Migrating 2.4.x to 2.6.x Question (include files)
Message-ID: <Pine.LNX.4.53.0401141051320.430@kryx.sk-tech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to install kernel 2.6.1 on a freshly installed Debian woody.

Well I got it working but ...

On 2.4.x I used to (soft) link

  /usr/src/linux-2.4.x/include/linux to /usr/include/linux

and

  /usr/src/linux-2.4.x/include/asm to /usr/include/asm

Well on 2.6.x .../include/linux is there, but .../include/asm is not.

I tried to link .../include/asm-i386 to .../include/asm (I've got an Intel
PC) ... but this doesn't let start the configuration run
(oldconfig/menuconfig).  Also some userlevel programms don't compile
correctly. - It seems that 2.6.x depends on the links in /usr/include ...

What I did now was to use my "old" asm (from 2.4.x) include directory

  ln -s /usr/src/linux-2.4.x/include/asm /usr/include/

and the "new" linux (from 2.6.x) include directory

  ln -s /usr/src/linux-2.6.x/include/linux /usr/include/

Which is probably not the correct way :( - What am I missing?

Help!

Thanx/Regards
  K. Sayah Karadji

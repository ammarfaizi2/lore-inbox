Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136037AbREJCm5>; Wed, 9 May 2001 22:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136035AbREJCmh>; Wed, 9 May 2001 22:42:37 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:593 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S136037AbREJCm2>; Wed, 9 May 2001 22:42:28 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: marius@umich.edu (marius aamodt eriksen)
cc: linux-kernel@vger.kernel.org
Subject: Re: odd insmod problem 
In-Reply-To: Your message of "Wed, 09 May 2001 12:54:00 -0400."
             <200105091654.MAA18672@xor.engin.umich.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 May 2001 12:41:16 +1000
Message-ID: <15081.989462476@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 May 2001 12:54:00 -0400, 
marius@umich.edu (marius aamodt eriksen) wrote:
>   insmod /usr/vice/etc/modload/libafs-2.4.4.o
>
>i get a whole bunch (50 in fact) unresolved symbols.  going through
>some of them, i can see that they do in fact exist.  for example:
>
>   root@gone:~ > grep inode_change_ok /proc/ksyms 
>   c013ff20 inode_change_ok_R66fc5011
>   root@gone:~ > grep inode_change_ok /boot/System.map
>   c013ff20 T inode_change_ok

Probably broken kernel Makefiles.  http://www.tux.org/lkml/#s8-8.


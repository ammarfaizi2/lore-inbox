Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRI0WdV>; Thu, 27 Sep 2001 18:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273999AbRI0WdM>; Thu, 27 Sep 2001 18:33:12 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:25096 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S273996AbRI0Wcy>; Thu, 27 Sep 2001 18:32:54 -0400
Date: Thu, 27 Sep 2001 19:27:45 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Reg modutils-2.4
Message-ID: <Pine.LNX.4.10.10109271920060.28586-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have to have two kernel images 2.2.14 and 2.4.9 to boot from. I
applied the kdb patch for 2.4.9 kernel but could find that make
bzImage failed because the modutils I have is 2.3.10. I thought of
upgrading my modutils and downloaded modutils-2.4.9-1.i386.rpm. It failed
saying   

  only packages with major numbers <= 3 are supported by this version of
RPM
error: modutils-2.4.9-1.i386.rpm cannot be installed
  
Then I tried with modutils-2.4.0-1.i386.rpm which failed giving so many
messages like the following:



file /sbin/depmod from install of modutils-2.4.0-1 conflicts with file
from package modutils-2.3.9-6
file /sbin/genksyms from install of modutils-2.4.0-1 conflicts with file
from package modutils-2.3.9-6
file /sbin/insmod from install of modutils-2.4.0-1 conflicts with file
from package modutils-2.3.9-6
file /sbin/insmod.static from install of modutils-2.4.0-1 conflicts with
file from package modutils-2.3.9-6
file /sbin/modinfo from install of modutils-2.4.0-1 conflicts with file
from package modutils-2.3.9-6
.
.
.

Please help me arriving at a solution.

Thanks in advance,
Warm regards,
sathish.j



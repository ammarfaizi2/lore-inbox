Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSJSFi6>; Sat, 19 Oct 2002 01:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265524AbSJSFi6>; Sat, 19 Oct 2002 01:38:58 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:31396 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265523AbSJSFi5>; Sat, 19 Oct 2002 01:38:57 -0400
Date: Sat, 19 Oct 2002 01:37:22 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.44 : unusual patching error
Message-ID: <Pine.LNX.4.44.0210190132570.966-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I performed a routine 
'patch -p1 <patch-2.5.44' within /usr/src/linux and received the following 
error:

patching file drivers/pnp/Makefile
patching file drivers/pnp/base.h
patching file drivers/pnp/compat.c
patching file drivers/pnp/core.c
patching file drivers/pnp/driver.c
patching file drivers/pnp/idlist.h
patching file drivers/pnp/interface.c
patching file drivers/pnp/isapnp/Makefile
patch: **** Can't rename file /tmp/poZqdzw2 to drivers/pnp/isapnp/Makefile : Not a directory

So, it seems i'll have a corrupted tree when I perform a 'patch -p1 -R 
<patch-2.5.44 ' , since it never finished patching the other files.
Has anyone observed this issue as well. Its unusual since I haven't run 
into this in prior patches.

Regards,
Frank


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSHKRau>; Sun, 11 Aug 2002 13:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSHKRau>; Sun, 11 Aug 2002 13:30:50 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:45321 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S313773AbSHKRau>;
	Sun, 11 Aug 2002 13:30:50 -0400
Date: Sun, 11 Aug 2002 12:54:36 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.31 : net/network.o error
Message-ID: <Pine.LNX.4.44.0208111252530.11441-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make bzImage', I received the following error.
Regards,
Frank

net/network.o: In function `unregister_8022_client':
net/network.o(.text+0x13ab0): undefined reference to `save_flags'
net/network.o(.text+0x13ab5): undefined reference to `cli'
net/network.o(.text+0x13aea): undefined reference to `restore_flags'
net/network.o: In function `unregister_snap_client':
net/network.o(.text+0x13c96): undefined reference to `save_flags'
net/network.o(.text+0x13c9b): undefined reference to `cli'
net/network.o(.text+0x13cf9): undefined reference to `restore_flags'
make: *** [vmlinux] Error 1



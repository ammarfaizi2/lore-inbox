Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSJJC6i>; Wed, 9 Oct 2002 22:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbSJJC6h>; Wed, 9 Oct 2002 22:58:37 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:51698 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262959AbSJJC6h>; Wed, 9 Oct 2002 22:58:37 -0400
Date: Wed, 9 Oct 2002 22:56:43 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.41-ac2 : llc_proc_exit undefined 
Message-ID: <Pine.LNX.4.44.0210092254500.9141-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I don't believe has been reported yet. While 'make bzImage' for 
2.5.41-ac2 , I receieved the following error:

net/built-in.o: In function `llc_init':
net/built-in.o(.text.init+0x8a1): undefined reference to `llc_proc_exit'
make: *** [.tmp_vmlinux1] Error 1


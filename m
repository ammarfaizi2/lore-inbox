Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTCCMwa>; Mon, 3 Mar 2003 07:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTCCMw3>; Mon, 3 Mar 2003 07:52:29 -0500
Received: from mavericks.onda.com.br ([200.195.192.20]:5808 "EHLO
	mavericks.onda.com.br") by vger.kernel.org with ESMTP
	id <S263321AbTCCMw2>; Mon, 3 Mar 2003 07:52:28 -0500
Date: Mon, 3 Mar 2003 10:02:10 -0300
From: Alexandre Hautequest <darkstar_hquest@hotmail.com>
X-X-Sender: operator@router.intranet
To: linux-kernel@vger.kernel.org
Subject: Raising FD number
Message-ID: <Pine.LNX.4.50.0303030944280.6005-100000@router.intranet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

How, in 2.4(.20), do i raise the number of file descriptors a process can
open? I have an app that could grown as high as 2k fds in about
hundreds of seconds (sorta of internet app) but i'm restricted to about
600 (after this, the great SYN i've received almost stops my machine for a while).

I've looked in the past messages, only found a thread from '99.

And i've changed value of __FD_SETSIZE to a really high value (16384) in
include/linux/posix_types.h and recompiled but didn't work.

In *BSDs i can change this w/ a select() system call, in linux isn't
working even if i hardcode value in.

Is this possible?

Please c/c me as i'm not subscribed to list.

Thanks in advance.

--
Alexandre Hautequest

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318591AbSIBXgZ>; Mon, 2 Sep 2002 19:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSIBXgZ>; Mon, 2 Sep 2002 19:36:25 -0400
Received: from 62-190-218-163.pdu.pipex.net ([62.190.218.163]:14084 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318591AbSIBXgY>; Mon, 2 Sep 2002 19:36:24 -0400
Date: Tue, 3 Sep 2002 00:48:23 +0100
From: jbradford@dial.pipex.com
Message-Id: <200209022348.g82NmNwY000237@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Recoverable RAM disk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know I brought up the subject of a recoverable RAM disk some time ago, (basically, a RAM disk that survives warm boots, and that can be made bootable itself), but this might actually be a good way to implement it...

This article:

http://hedera.linuxnews.pl/_news/2002/09/03/_long/1445.html

demonstrates making a RAM disk using graphics card memory.

Now, the video ram would presumably survive a warm boot in most cases, so if we could implement this idea in kernel space, we could keep a kernel image and root filesystem in the last 12 Mb or so of graphics RAM, and warm boot very quickly.

John.

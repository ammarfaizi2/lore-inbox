Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSJ1WHR>; Mon, 28 Oct 2002 17:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSJ1WHQ>; Mon, 28 Oct 2002 17:07:16 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:3805 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261565AbSJ1WHO>; Mon, 28 Oct 2002 17:07:14 -0500
Message-ID: <3DBDB615.6040805@hotmail.com>
Date: Mon, 28 Oct 2002 14:11:33 -0800
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1) Gecko/20021023
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.44-ac5 panic with ppa(ZIP) driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a panic on bootup with the ppa driver compiled into
the kernel.

With ppa compiled as a module I get severak "bad: scheduling
while atomic!" errors during the modprobe, and then modprobe
exits with preempt_count 1 and a segfault error.

Strangely, even after all the horrible error messages the
ZIP disk actually works, as long as ppa is a module.

I'm running debian/testing with modprobe version 2.4.19
and gcc 2.95.4 20011002.


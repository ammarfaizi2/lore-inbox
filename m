Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265806AbUGEHOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265806AbUGEHOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 03:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUGEHOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 03:14:55 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:60665 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S265806AbUGEHOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 03:14:52 -0400
Message-ID: <40E900CE.9020502@sdl.hitachi.co.jp>
Date: Mon, 05 Jul 2004 16:18:38 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] LKST 2.1.0 for linux-2.6.6 is released.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

We are pleased to announce releasing new version of Linux Kernel State
Tracer.

The Linux Kernel State Tracer(a.k.a. LKST) version 2.1.0 has been
released. This version can be applied to linux-2.6.6. And platforms of
LKST 2.1.0 are both IA32 and IA64.

LKST is a tool that supports to analyze of fault and evaluate for kernel.
Especially it is usuful for analyzing the unanticipated fault of kernal.

The latest version of the LKST has new features:

- LSM hooking addon module.
   If you use this module, you can trace more detailed information of
system calls.
   And you can use this module with SELinux.

- event flags which show the attribute of an event.
   You can get the attribute of events from /proc/lkst_etypes
   For more details, see howto.txt.

For more changes, see Changelog-2.1.0.txt
<http://prdownloads.sourceforge.net/lkst/Changelog-2.1.0.txt?download>

Remarks:
For supporting IA64, we hacked KernelHooks.

LKST binaries, source code and documents are available in the following
site,
https://sourceforge.net/projects/lkst/
http://sourceforge.jp/projects/lkst/

We prepared a mailing list written below in order to let users know
update of LKST.

lkst-users@lists.sourceforge.net
lkst-users@lists.sourceforge.jp

To subscribe, please refer following URL,

http://lists.sourceforge.net/lists/listinfo/lkst-users
http://lists.sourceforge.jp/mailman/listinfo/lkst-users

And if you have any comments, please send to the above list, or to
another mailing-list written below.

lkst-develop@lists.sourceforge.net
lkst-develop@lists.sourceforge.jp

With kindest regards,
All of the LKST developers

-- 
Masami HIRAMATSU

3rd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp


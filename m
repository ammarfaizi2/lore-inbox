Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264719AbUD1KSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbUD1KSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264720AbUD1KSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:18:50 -0400
Received: from benzin.geggus.net ([82.139.198.100]:37905 "EHLO
	benzin.geggus.net") by vger.kernel.org with ESMTP id S264719AbUD1KSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:18:48 -0400
To: linux-kernel@vger.kernel.org
Path: news.geggus.net!not-for-mail
From: Sven Geggus <sven-im-usenet@gegg.us>
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Date: Wed, 28 Apr 2004 12:18:46 +0200 (CEST)
Organization: Geggus clan, virtual section
Message-ID: <c6o0e6$2ck$1@benzin.geggus.net>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen> <20040427230203.1e4693ac.akpm@osdl.org>
NNTP-Posting-Host: ::1
X-Trace: benzin.geggus.net 1083147526 2453 ::1 (28 Apr 2004 10:18:46 GMT)
X-Complaints-To: usenet@geggus.net
NNTP-Posting-Date: Wed, 28 Apr 2004 10:18:46 +0000 (UTC)
X-TERMINAL: rxvt
X-OS: Debian GNU/Linux (Kernel 2.4.26-exec-shield)
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-exec-shield (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> It's a shame this wasn't reported earlier.

I did report this behaviour in <c6gi0f$g6i$1@benzin.geggus.net> a few days
ago.

> Please confirm that the problem is observed on the NFS client and not the
> NFS server?  I'll assume the client.

Shure! The problem is observed on the NFS client, a diskless machine in my
case.

> What other filesystems are in use on the client?

Non in my case!

> Please describe the NFS mount options and the number of CPUs and the amount
> of memory in the machine.

NFS mount options are default and my machine does not use an SMP Kernel (AMD
Athlon 2000+, Single CPU).

Sven

-- 
/*
 * Wirzenius wrote this portably, Torvalds fucked it up :-)
 */                        (taken from /usr/src/linux/lib/vsprintf.c)
/me is giggls@ircnet, http://sven.gegg.us/ on the Web

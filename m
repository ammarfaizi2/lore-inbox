Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTLEOKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTLEOKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:10:55 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:9488 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264128AbTLEOKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:10:54 -0500
To: lkml-031128@amos.mailshell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
References: <20031128170138.9513.qmail@mailshell.com>
	<87d6bc2yvq.fsf@devron.myhome.or.jp>
	<20031129170034.10522.qmail@mailshell.com>
	<1070242158.1110.150.camel@buffy> <3FCBAE6F.1090405@myrealbox.com>
	<20031201213624.18232.qmail@mailshell.com>
	<871xrmudyb.fsf@devron.myhome.or.jp>
	<20031205112319.31918.qmail@mailshell.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 05 Dec 2003 23:10:40 +0900
In-Reply-To: <20031205112319.31918.qmail@mailshell.com>
Message-ID: <87u14fwe1r.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml-031128@amos.mailshell.com writes:

> 1. From a multi-user mode, after an uptime of 5 days (test11 with your
> fix).
> 2. killed the ppp daemon (/etc/init.d/ppp stop). Made sure the ppp0
> interface is down.
> 3. did "head -1 /proc/net/tcp" and "cat /proc/net/tcp". Passed fine.
> 4. re-startted ppp daemon.
> 5. System is fine. No kernel errors. PPP works flowlessly.
> 
> So I think my linking of PPP to the fix was wrong. Maybe the PPP failure
> was unrelated to this.

Thanks for trying it.
Several peoples was reporting the similar PPP failure. Umm...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

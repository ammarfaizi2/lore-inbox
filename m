Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWCQRqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWCQRqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWCQRqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:46:30 -0500
Received: from mail.linicks.net ([217.204.244.146]:63196 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1030229AbWCQRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:46:30 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: chmod 111
Date: Fri, 17 Mar 2006 17:46:18 +0000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171746.18894.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

First, I apologise if this isn't a kernel question, but I think it is related.

Slackware 10 base, 2.6.15.6

I am normal user, in groups users and wheel.  Why can I do this:


nick@linuxamd:nick$ which ls
/usr/bin/ls
nick@linuxamd:nick$ ls -lsa /usr/bin/ls
0 lrwxrwxrwx  1 root root 12 2004-07-22 22:52 /usr/bin/ls -> ../../bin/ls
nick@linuxamd:nick$ cd /bin
nick@linuxamd:bin$ sudo chmod 111 ls
nick@linuxamd:bin$ ls -lsa ls
76 ---x--x--x  1 root bin 72608 2004-03-16 02:08 ls



I shouldn't be able to execute 'ls' as I can't read it, shouldn't it?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

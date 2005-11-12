Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVKLONj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVKLONj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVKLONj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:13:39 -0500
Received: from mail.linicks.net ([217.204.244.146]:30917 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932379AbVKLONi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:13:38 -0500
From: Nick Warne <nick@linicks.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ext3: Fix warning without quota support (was: Linux 2.6.14)
Date: Sat, 12 Nov 2005 14:12:34 +0000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121412.35029.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry for not spotting this one earlier...
>
> Fix the following warning when ext3 fs is compiled without quota
> support:
>
> fs/ext3/super.c: In function `ext3_show_options':
> fs/ext3/super.c:516: warning: unused variable `sbi'

I have added this small fix to my 2.6.14.2 build.  A quick question.

What does GCC do here - does it just drop and ignore the unused variable?

Nick
-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb


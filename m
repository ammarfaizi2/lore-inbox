Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVFVTh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVFVTh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFVTh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:37:27 -0400
Received: from mail.linicks.net ([217.204.244.146]:35076 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261823AbVFVThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:37:21 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org, George Kasica <georgek@netwrx1.com>
Subject: Re: Problem compiling 2.6.12
Date: Wed, 22 Jun 2005 20:37:17 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506222037.17738.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Kasica wrote:

> Tried that here and got not much farther...here's the error:
> 
> [root@eagle linux]# make bzImage
>    CHK     include/linux/version.h
>    SPLIT   include/linux/autoconf.h -> include/config/*
>    HOSTCC  scripts/mod/sumversion.o
> In file included from /usr/include/linux/errno.h:4,

That last line looks wrong...  I think you may have symlinks linking to other 
older kernel header stuff.

Easy way to test is untar the Linux.2.6.12 to a totally new location 
(say /home/~/tmp/) and try a build with just the default config.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

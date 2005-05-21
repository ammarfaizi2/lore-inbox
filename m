Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVEUWil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVEUWil (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVEUWil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 18:38:41 -0400
Received: from mail.portrix.net ([212.202.157.208]:35253 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261661AbVEUWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 18:38:39 -0400
Message-ID: <428FB853.8070205@ppp0.net>
Date: Sun, 22 May 2005 00:38:11 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050331 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binutils-2.16 & kernel-2.6.11.10
References: <200505212125.j4LLP3s2017196@wildsau.enemy.org>
In-Reply-To: <200505212125.j4LLP3s2017196@wildsau.enemy.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:
> hi,
> 
> the "not being able to compile kernel with latest binutils" problem is also
> present in 2.6.11.10, at least in:
> 
> arch/i386/kernel/process.c
> arch/i386/kernel/vm86.c
> include/asm-i386/system.h
> 
> substituting movl with movw for segreg moves will make it work again,
> but I don't know if these are the only files which are probably affected, too.

http://www.kernel.org/pub/linux/devel/binutils/linux-2.6-seg-5.patch
http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch

should probably fix that.

-- 
Jan

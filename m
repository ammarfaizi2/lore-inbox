Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264764AbRF1WTV>; Thu, 28 Jun 2001 18:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264769AbRF1WTL>; Thu, 28 Jun 2001 18:19:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45329 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264745AbRF1WS6>; Thu, 28 Jun 2001 18:18:58 -0400
Subject: Re: PROBLEM: kernel bug at page_alloc.c:81
To: khan_55@linuxfreemail.com
Date: Thu, 28 Jun 2001 23:18:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106282214.f5SMEw107141@superglide.netfx-2000.net> from "khan_55@linuxfreemail.com" at Jun 28, 2001 03:14:58 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fk7Z-0007kP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1	After a 'shutdown -h now', I get a kernel bug at page_alloc.c:81
> 2	After being in X (only happens after being in X), I get out of X, and as root I do a 'shutdown -h now'.  It goes through the shutdown process normally, and then after it prints "Syncing hardware clock to system time [ OK ]", I get:
> Modules Loaded         ipt_state ipt_limit iptable_filter ipt_LOG ipt_MASQUERADE ipt_REDIRECT iptable_nat ip_conntrack ip_tables ppp_deflate au8820 ppp_async ppp_generic slhc NVdriver
> 

You have binary modules loaded (nvdriver, au8820) that we can't debug and
have no reason to believe are correct. Take your bug report to these people
or duplicate it from a clean boot without loading eith NVdriver or au8820

They have our source, we dont have theirs, so only they can help you


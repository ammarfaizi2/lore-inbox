Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275908AbSIUMYU>; Sat, 21 Sep 2002 08:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275909AbSIUMYU>; Sat, 21 Sep 2002 08:24:20 -0400
Received: from quechua.inka.de ([212.227.14.2]:34172 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S275908AbSIUMYU>;
	Sat, 21 Sep 2002 08:24:20 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __KERNEL__ pasting in drivers/net/wan/cycx_x25.c
In-Reply-To: <20020921112245.27021.qmail@unibar>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17sjO4-00008j-00@sites.inka.de>
Date: Sat, 21 Sep 2002 14:29:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020921112245.27021.qmail@unibar> you wrote:
> This patch cleans up the __FUNCTION__ pasting to the new
> standard.

is this normal, that we dont have a rate limit in those functions? And even
worse, that there is no error handling like signalling this back to the
channel? In this case this looks especially annoying, since it is a state
changing event, if when lost may totally screw up the state engine (if i
understand the comment "Send event (connection, disconnection, etc) to X.25
socket layer" right.

Greetings
Bernd

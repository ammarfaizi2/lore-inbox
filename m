Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSGOCr6>; Sun, 14 Jul 2002 22:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSGOCr5>; Sun, 14 Jul 2002 22:47:57 -0400
Received: from quechua.inka.de ([212.227.14.2]:11118 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S317280AbSGOCr4>;
	Sun, 14 Jul 2002 22:47:56 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: route cache corruption
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17Tvwn-0000uH-00@sites.inka.de>
Date: Mon, 15 Jul 2002 04:50:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could this be the cause of this phenomena, or am I barking up the
> wrong tree?

Start with route -F and route -C output, for example. IT sounds like a
interface or neighbour was detected dead and another metric route matched.

Greetings
Bernd

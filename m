Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbSJSTBk>; Sat, 19 Oct 2002 15:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265660AbSJSTBj>; Sat, 19 Oct 2002 15:01:39 -0400
Received: from quechua.inka.de ([212.227.14.2]:20074 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265659AbSJSTBj>;
	Sat, 19 Oct 2002 15:01:39 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
In-Reply-To: <20021019134445.B28191@ma-northadams1b-3.bur.adelphia.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E182ywo-0007WY-00@sites.inka.de>
Date: Sat, 19 Oct 2002 21:07:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021019134445.B28191@ma-northadams1b-3.bur.adelphia.net> you wrote:
> I do like the idea of preventing multiple chroots, as a second option.

this is not enough to allow chroot for non root. There are just too many
suid programs which rely on absolute path. So if one allows chroot() for
non-root users, the usage of suid/sgid must be forbidden, too.


Greetings
bernd

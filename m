Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbSKLQJP>; Tue, 12 Nov 2002 11:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbSKLQJP>; Tue, 12 Nov 2002 11:09:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:53194 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S266633AbSKLQJP>;
	Tue, 12 Nov 2002 11:09:15 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
In-Reply-To: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E18Bdht-0001Sx-00@sites.inka.de>
Date: Tue, 12 Nov 2002 17:16:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1037115535.1439.5.camel@beowulf.cryptocomm.com> you wrote:
> Is this a kernel limitation? If yes, how can I get around it?
> If no, anyone know a workaround? I appreciate it.

the * is expanded to a string, which is too long to be handed as a single
command line argument. Think it is in the kernel, yes. You can solve this by
using find|xargs or tar|tar or by specifying a directory.

Greetings
Bernd

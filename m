Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316270AbSEKTzJ>; Sat, 11 May 2002 15:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316271AbSEKTzI>; Sat, 11 May 2002 15:55:08 -0400
Received: from quechua.inka.de ([212.227.14.2]:3610 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S316270AbSEKTzH>;
	Sat, 11 May 2002 15:55:07 -0400
From: Bernd Eckenfels <ecki-news2002-04@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT performance impact on 2.4.18
In-Reply-To: <Pine.LNX.4.44.0205111047280.2355-100000@home.transmeta.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E176cxO-0000VC-00@sites.inka.de>
Date: Sat, 11 May 2002 21:55:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0205111047280.2355-100000@home.transmeta.com> you wrote:
> I bet you could get _better_ performance more cleanly by splitting up the
> actual IO generation and the "user-space mapping" thing sanely. For
> example, if you want to do an O_DIRECT read into a buffer, there is no
> reason why it shouldn't be done in two phases:

This works for your load, but it does not work for the load it is designed
for. Sequentially reading and througput is not the way to measure it. You
need random reading and lattency to see it's merrits.

Greetings
Bernd

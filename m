Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSG3Wtv>; Tue, 30 Jul 2002 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSG3Wtu>; Tue, 30 Jul 2002 18:49:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10505 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317073AbSG3Wtt>; Tue, 30 Jul 2002 18:49:49 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: janitorial PATCH: 2.4:  nvram.c Lindent
Date: Tue, 30 Jul 2002 22:52:53 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ai75c5$1ft$1@penguin.transmeta.com>
References: <3D47170E.20003@sun.com>
X-Trace: palladium.transmeta.com 1028069569 439 127.0.0.1 (30 Jul 2002 22:52:49 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 30 Jul 2002 22:52:49 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D47170E.20003@sun.com>, Tim Hockin  <thockin@sun.com> wrote:
>
>This patch is pretty simple:  It runs drivers/char/nvram.c through 
>Lindent, with a few manual cosmetics on top.  I'm sending this now 
>because it makes my follow-up patch to this file easier :)

Hmm.

If you're doing these kinds of Lindent changes, you might as well also
fix another non-linuxism:

	return (x);	->	return x;

I don't know why some people seem to think that "return" is a function
with an argument..

I guess that one isn't mentioned in the CodingStyles thing. I'm lazy.
Bad Bad Linus.

		Linus

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSEYTlE>; Sat, 25 May 2002 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSEYTlD>; Sat, 25 May 2002 15:41:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315266AbSEYTlD>; Sat, 25 May 2002 15:41:03 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: isofs unhide option:  troubles with Wine
Date: Sat, 25 May 2002 19:40:04 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <acopak$1th$1@penguin.transmeta.com>
In-Reply-To: <1022301029.2443.28.camel@jwhiteh>
X-Trace: palladium.transmeta.com 1022355642 16519 127.0.0.1 (25 May 2002 19:40:43 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 25 May 2002 19:40:43 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1022301029.2443.28.camel@jwhiteh>,
Jeremy White  <jwhite@codeweavers.com> wrote:
>
>    3.  Make it so that isofs/dir.c still strips out hidden
>        files, but enable isofs/namei.c to return a hidden file that
>        is opened directly by name.

I think this is the right solution.

		Linus

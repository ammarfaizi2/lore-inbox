Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268138AbRGZPxp>; Thu, 26 Jul 2001 11:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268134AbRGZPxg>; Thu, 26 Jul 2001 11:53:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268107AbRGZPxR>; Thu, 26 Jul 2001 11:53:17 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ext3-2.4-0.9.4
Date: Thu, 26 Jul 2001 15:51:35 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9jpea7$s25$1@penguin.transmeta.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org>
X-Trace: palladium.transmeta.com 996162793 14972 127.0.0.1 (26 Jul 2001 15:53:13 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Jul 2001 15:53:13 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <20010726143002.E17244@emma1.emma.line.org>,
Matthias Andree  <matthias.andree@stud.uni-dortmund.de> wrote:
>
>However, the remaining problem is being synchronous with respect to open
>(fixed for ext3 with your fsync() as I understand it), rename, link and
>unlink. With ext2, and as you write it, with ext3 as well, there is
>currently no way to tell when the link/rename has been committed to
>disk, unless you set mount -o sync or chattr +S or call sync() (the
>former is not an option because it's far too expensive).

Congratulations. You have been brainwashed by Dan Bernstein.

Use fsync() on the directory. 

Logical, isn't it?

		Linus

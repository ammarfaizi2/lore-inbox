Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSGJLUp>; Wed, 10 Jul 2002 07:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSGJLUo>; Wed, 10 Jul 2002 07:20:44 -0400
Received: from mail.storm.ca ([209.87.239.66]:29913 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S315595AbSGJLUm>;
	Wed, 10 Jul 2002 07:20:42 -0400
Message-ID: <3D2C0C3A.FB0FFBE9@storm.ca>
Date: Wed, 10 Jul 2002 06:28:10 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.GSO.4.21.0207100050050.3293-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> Again, the real mess is due to the way we use cpp. ...
> 
> As it is, we have way too many ifdefs to hope that any automated tool
> would be able to cope with the damn thing.  It used to be worse -
> these days several really nasty piles of ifdefs are gone.  However,
> we still have quite a few remaining.
> 
> Quick-and-dirty search shows ~1.2e4 ifdefs on CONFIG_... in the tree.
> Most of them - patently ridiculous ...

There's a classic Usenix paper "#ifdef Considered Harmful":
http://www.google.ca/search?q=cache:kOjOJGuyArgC:www.literateprogramming.com/ifdefs.pdf+ifdef+considered+harmful&hl=en&ie=UTF-8

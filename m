Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271105AbRH1OX7>; Tue, 28 Aug 2001 10:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271082AbRH1OXt>; Tue, 28 Aug 2001 10:23:49 -0400
Received: from mail.internet-factory.de ([195.122.142.5]:43985 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S271105AbRH1OXf>; Tue, 28 Aug 2001 10:23:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: [FAQ?] More ram=less performance (maximum cacheable RAM)
Date: Tue, 28 Aug 2001 16:23:52 +0200
Organization: Internet Factory AG
Message-ID: <3B8BA978.47EF9D77@internet-factory.de>
In-Reply-To: <3B82B988.50DE308A@iname.com> <200108211957.f7LJvEt20846@vindaloo.ras.ucalgary.ca>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 999008632 28875 195.122.142.158 (28 Aug 2001 14:23:52 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 28 Aug 2001 14:23:52 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac12 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch proclaimed:

> Er, are you sure about this? The problem isn't the size of your cache,
> it's the size of your TAG RAM. That's a different beast.

Cachable memory area is a function of cache size, tag size and cache
mode (wb or wt - first needs dirty tag, second doesn't). With VIA MVP3
boards for example, cachable memory depends on the size of the cache.
Which is why most of the boards with this chipset had 1 MB level 2 cache
(enough for 128 mb with writeback or 256 mb with writethrough), some
even had 2 MB (for twice that).

Holger

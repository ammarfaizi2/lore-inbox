Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSFCD32>; Sun, 2 Jun 2002 23:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSFCD31>; Sun, 2 Jun 2002 23:29:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10501 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313773AbSFCD30>; Sun, 2 Jun 2002 23:29:26 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: KBuild 2.5 Impressions
Date: Mon, 3 Jun 2002 03:28:37 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <adenp5$1d9$1@penguin.transmeta.com>
In-Reply-To: <3CFAD94B.F848897B@kegel.com>
X-Trace: palladium.transmeta.com 1023074953 18859 127.0.0.1 (3 Jun 2002 03:29:13 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 3 Jun 2002 03:29:13 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3CFAD94B.F848897B@kegel.com>, Dan Kegel  <dank@kegel.com> wrote:
>
>Linus sees Kai as being the most promising fellow to
>integrate kbuild2.5 right now [...]

Side note, just to explain _why_ I prefer it done this way, so that
people can understand - even if they don't necessarily have to agree
with - why this is my preferred approach.

There's actually several reasons:

 - I always hate "flag day" patches. Do they happen? Sure. Some people
   have already given examples of such big flag-day patches, the ALSA
   merge being one prime example.  That doesn't mean that I like them
   any more for that.

   In short: if at all possible, I _much_ prefer gradual merges, where
   "gradual" really means that features are added one-by-one (and that
   does _not_ mean "build up the infrastructure slowly, so that the
   final 'flag-day' patch itself is small but has large ramifications")

 - Kai has already shown that he can merge with me easily, and actually
   took one traditional flag-day-project (ISDN: every single merge was a
   flag-day merge), and has turned that into a very easy gradual merge
   for me. I used to dread ISDN merges, these days I don't even have to
   think about them.

 - Kai obviously already knows the build system, as he has been doing a
   lot of incremental stuff on it already.

 - Kai isn't an enthusiastic kbuild-2.5 supporter. In fact, he tends to
   be a bit down on some of it. Which is a plus in my book: it means
   that whatever Kai tries to push my way I'll feel just that much more
   comfortable with as having had critical review.

So let's see how it works out.  Maybe it won't, but this would seem
workable at least in theory. 

		Linus

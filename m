Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSA2WYD>; Tue, 29 Jan 2002 17:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbSA2WXn>; Tue, 29 Jan 2002 17:23:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39951 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284902AbSA2WXi>; Tue, 29 Jan 2002 17:23:38 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 22:22:46 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a377bn$1go$1@penguin.transmeta.com>
In-Reply-To: <p73aduwddni.fsf@oldwotan.suse.de> <200201292208.g0TM8ql17622@ns.caldera.de>
X-Trace: palladium.transmeta.com 1012342998 29816 127.0.0.1 (29 Jan 2002 22:23:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Jan 2002 22:23:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200201292208.g0TM8ql17622@ns.caldera.de>,
Christoph Hellwig  <hch@ns.caldera.de> wrote:
>In article <p73aduwddni.fsf@oldwotan.suse.de> you wrote:
>> "Most times". For example the EA patches have badly failed so far, just because
>> Linus ignored all patches to add sys call numbers for a repeatedly discussed 
>> and stable API and nobody else can add syscall numbers on i386. 
>
>There still seems to be a lot of discussion vs EAs and ACLs.
>Setting the suboptimal XFS APIs in stone doesn't make the discussion
>easier.

In fact, every time I thought that the extended attributes had reached
some kind of consensus, somebody piped up with some apparently major
complaint. 

I think last time it was Al Viro.  Admittedly (_very_ much admittedly),
making Al happy is really really hard.  His perfectionism makes his
patches very easy to accept, but they make it hard for others to try to
make _him_ accept patches.  But since he effectively is the VFS
maintainer whether he wants it to be written down in MAINTAINERS or not,
a comment from him on VFS interfaces makes me jump. 

The last discussion over EA's in my mailbox was early-mid December, and
there were worries from Al and Stephen Tweedie.  I never heard from the
worried people whether their worries were calmed.

Maybe they did, and maybe they didn't.  If somebody doesn't tell me that
they are resolved, and that the people who would actually _use_ and
maintain this interface agrees on it, how can you expect me to ever
apply a patch?

			Linus

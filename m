Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293191AbSBWTlS>; Sat, 23 Feb 2002 14:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293192AbSBWTlJ>; Sat, 23 Feb 2002 14:41:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14091 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293191AbSBWTkx>; Sat, 23 Feb 2002 14:40:53 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.4 bitkeeper repository
Date: Sat, 23 Feb 2002 19:40:31 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a58r7f$in$1@penguin.transmeta.com>
In-Reply-To: <20020222104232.D28253@work.bitmover.com> <Pine.LNX.4.33L.0202221634230.7820-100000@imladris.surriel.com> <20020222114522.G7909@work.bitmover.com>
X-Trace: palladium.transmeta.com 1014493249 26295 127.0.0.1 (23 Feb 2002 19:40:49 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 23 Feb 2002 19:40:49 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020222114522.G7909@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:
>We need to tweak stuff so that you can use bk import -temail or something
>like that and it's a combination of Linus' scripts and the current code.
>Linus?  Scripts?

My scripts are on master.kernel.org:/home/torvalds/BK/tools, although I
haven't bothered to clean some of them up that really should be cleaned
up (things like email parsing that breaks on some emails due to MIME
and/or "^From " in the body etc). 

Those tools include all the scripts to make changelogs, apply patches
from emails etc.

And they require the recent bitkeeper that can take comments and user
information for "bk import -tpatch". 

(Yeah, "master" isn't an open machine, but Marcelo, Rik, Jeff etc can
all get in on it, if somebody wants to push the tools out somewhere else
they can certainly do so).

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269022AbTCAU7d>; Sat, 1 Mar 2003 15:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269023AbTCAU7c>; Sat, 1 Mar 2003 15:59:32 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:22453 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S269022AbTCAU7c>; Sat, 1 Mar 2003 15:59:32 -0500
Message-ID: <3E612409.7090603@kegel.com>
Date: Sat, 01 Mar 2003 13:20:09 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> 	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>
In-Reply-To: <1046546305.10138.415.camel@spc1.mesatop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> Once you've loosed your beast upon the tree, I'd suggest that you
> very carefully look through the resulting diff for inappropriate
> corrections and redact the unnecessary hunks.  In the spelling fixes
> which I sent to Linus, I redacted hunks which didn't need fixing.  For
> example, Linus making fun of Sun folks' ability to spell, etc. and some
> comments in French or German for which the spelling was correct in those
> languages.

Good points.

> In addition to making fixes in the comments in the source, all of
> Documentation should be fair game.

Yeah, but that's easy :-)

> Then you'll have to contend with the folks whose out-of-tree patches
> you've borked.

That's a good argument for making the spellfix program polished
enough that everyone can use it, I think.  Those maintaining
out-of-tree patches can run the tool on their tree, and regenerate
diffs.

- Dan



-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268366AbTCCF12>; Mon, 3 Mar 2003 00:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268373AbTCCF12>; Mon, 3 Mar 2003 00:27:28 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:46075 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S268366AbTCCF11>; Mon, 3 Mar 2003 00:27:27 -0500
Message-ID: <3E62ECB8.4010409@kegel.com>
Date: Sun, 02 Mar 2003 21:48:40 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: David Woodhouse <dwmw2@infradead.org>,
       Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       mike@aiinc.ca, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>	<3E6101DE.5060301@	 	kegel.com>	<1046546305.10138.415.camel@spc1.mesatop.com>	<3E6167B1.6040206@k	 egel.com>	<3E617428.3090207@kegel.com>	<1046578585.2544.451.camel@spc1.mesatop.com>	<	1046604117.12947.16.camel@imladris.demon.co.uk>	<1046612993.7527.472.camel@s	 pc1.mesatop.com>  <3E62C0FF.1090700@kegel.com>	<1046661777.7527.518.camel@spc1.mesatop.com>  <3E62E4C0.9070103@kegel.com> <1046668274.7527.533.camel@spc1.mesatop.com>
In-Reply-To: <1046668274.7527.533.camel@spc1.mesatop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> BTW, I ran the spell-fix.pl script using only the first 10 entries
> of spell-fix.txt (an arbitrary choice), and got a pretty big diff:
> 
>  132 files changed, 199 insertions(+), 199 deletions(-)
> 
> My feeling is that patches should be about 1/4 that size.
> Otherwise, Linus may /dev/null them.  Second opinion anyone?

I agree with the 1/4th, but in # of lines of spell-fix.txt, not
in output size.

Looking at the changesets he's accepted, it looks like he's
comfortable with changesets of 100 files (see "don't" fixes at
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-1.1025.1.38.txt )
It probably helps that this was a single kind of change.

My guess is these things need enough manual reviewing
that keeping it down to just a related group of fixes per patch
is a good idea (e.g.
Acknowledge=Acknowlege
acknowledged=acknoledged
together are a Good Idea, more is probably bad).

BTW Linus has been accepting so many spell fixes it's probably important
to work with very fresh sources...
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


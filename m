Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269086AbTCBClS>; Sat, 1 Mar 2003 21:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269091AbTCBClS>; Sat, 1 Mar 2003 21:41:18 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:1753 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S269086AbTCBClR>; Sat, 1 Mar 2003 21:41:17 -0500
Message-ID: <3E617428.3090207@kegel.com>
Date: Sat, 01 Mar 2003 19:02:00 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: Steven Cole <elenstev@mesatop.com>, Matthias Schniedermeyer <ms@citd.de>,
       Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> 	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com> <3E6167B1.6040206@kegel.com>
In-Reply-To: <3E6167B1.6040206@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My corrections file is up at http://www.kegel.com/spell-fix-dan1.txt
and the patch that produces is
http://www.kegel.com/linux-2.5.63-bk5-spell.patch.bz2.bin
The perl script took about an hour of 450MHz cpu time.
(Might be worth adding a quick path to detect and skip
files with none of the misspelled words.  Or just run
on a fast machine...)

I did a spot check, and it looked pretty good, but some
of the fixes are just too pedantic.  In particular,
   decrementor=decrementer
should probably be dropped from the fix list.

Any other changes people want to see in the script
or the corrections file?   Should I add fixes for
uncommon errors (those that happen only in one or two files)?

- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


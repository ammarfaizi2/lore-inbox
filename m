Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268281AbTCCCIQ>; Sun, 2 Mar 2003 21:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268286AbTCCCIQ>; Sun, 2 Mar 2003 21:08:16 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:1007 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S268281AbTCCCIP>; Sun, 2 Mar 2003 21:08:15 -0500
Message-ID: <3E62BE04.1090506@kegel.com>
Date: Sun, 02 Mar 2003 18:29:24 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Steven Cole <elenstev@mesatop.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>	 <3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>	 <3E6167B1.6040206@kegel.com>  <3E617428.3090207@kegel.com>	 <1046578585.2544.451.camel@spc1.mesatop.com>	 <1046604117.12947.16.camel@imladris.demon.co.uk>	 <1046612993.7527.472.camel@spc1.mesatop.com> <1046645090.3698.40.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1046645090.3698.40.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>I think we also want to add:
>>>
>>>Decompressing=Uncompressing
> 
> 
> Both are commonly used. People are going to far. Fixing typos that are
> confusing or blatantly daft is one thing, but if you want to pick over
> documentation line by line with a copy of Fowlers in hand the Gnome and
> KDE projects would both love to have you working over their
> documentation and end user manuals ;)

Agreed.  Confusing and blatantly daft typos are my intended target.

I've put all of my scripts and data up at
   http://www.kegel.com/kerspell
including an ispell filter (haven't tried it out yet)
and a stopword list.

Here's example output from my lspell.pl script using my stopword list:

linux-2.5.63-bk5.old/include/asm-s390x/atomic.h: 1

enviroment

linux-2.5.63-bk5.old/include/asm-s390x/rwsem.h: 1

consequtive

linux-2.5.63-bk5.old/include/asm-s390x/dasd.h: 3

featueres Perfomance requests's

linux-2.5.63-bk5.old/include/asm-s390x/pgtable.h: 3

lenght regiontable specifiation

...


- Dan


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


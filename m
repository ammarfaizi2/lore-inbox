Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269137AbTCBHnV>; Sun, 2 Mar 2003 02:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269138AbTCBHnV>; Sun, 2 Mar 2003 02:43:21 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:12177 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S269137AbTCBHnU>; Sun, 2 Mar 2003 02:43:20 -0500
Message-ID: <3E61BAF9.7080205@kegel.com>
Date: Sun, 02 Mar 2003 00:04:09 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>	<3E6167B1.6040206@kegel.com>  <3E617428.3090207@kegel.com> <1046577278.2543.445.camel@spc1.mesatop.com>
In-Reply-To: <1046577278.2543.445.camel@spc1.mesatop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> trigging=triggerg
> ^^^^^^^^
> This should be "triggering" here (I hope).

Right, thanks.  (I had that one right, once, but must have
dropped it on the floor.)

 > Hmm, psuedo didn't get caught.  Is psuedo code particularly smooth?

:-)

OK, http://www.kegel.com/spell-fix-dan2.txt is up, with the
following changes:

78d77
< decrementor=decrementer
158d156
< Licensed=Licenced
198a197
 > pseudo=psuedo
271c270
< trigging=triggerg
---
 > triggering=triggerg

The above covers errors in three or more source files.

The next logical step was to do the words misspelled in exactly
two source files.  I did gather a list of them
( http://www.kegel.com/errors2.txt ) but
I don't have the energy to make a corrections file for those
right now.  (FWIW, the procedure is: copy to a new file,
run aspell and consult original source, then use 'paste'
to join input and output of aspell into a two-column file)
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


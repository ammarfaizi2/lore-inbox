Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRJXOin>; Wed, 24 Oct 2001 10:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275115AbRJXOid>; Wed, 24 Oct 2001 10:38:33 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:34369 "HELO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with SMTP
	id <S274862AbRJXOiU>; Wed, 24 Oct 2001 10:38:20 -0400
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Two suggestions (loop and owner's of linux tree)
In-Reply-To: <1003933278.1496.6.camel@LNX.iNES.RO>
X-Newsgroups: wsisiz.linux-kernel
User-Agent: tin/1.5.9-20010723 ("Chord of Souls") (UNIX) (Linux/2.4.12 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Message-Id: <20011024143850.EAC2598410@oceanic.wsisiz.edu.pl>
Date: Wed, 24 Oct 2001 16:38:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1003933278.1496.6.camel@LNX.iNES.RO> you wrote:
>> I would like to suggest to change max_loop from 8 to 16 or more if it
>> possible.

> max_loop=16 in your kernel command line if you use loop builtin or:
> options loop max_loop=16 in /etc/modules.conf if you use it as an
> module.

I know about this option, but I think limit max=16 is much better.

> chmod -R root.root linux/ 
> after you have unpacked the tarball.

Unnecessarily extra command :) Sometimes I can forget about this and then
user with uid 1046 can modify my kernel source.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

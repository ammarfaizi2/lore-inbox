Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264400AbRFXTQl>; Sun, 24 Jun 2001 15:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264405AbRFXTQb>; Sun, 24 Jun 2001 15:16:31 -0400
Received: from zeus.kernel.org ([209.10.41.242]:42465 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264400AbRFXTQP>;
	Sun, 24 Jun 2001 15:16:15 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: What are the VM motivations??
Date: Sun, 24 Jun 2001 19:11:09 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9h5e0d$rdq$1@forge.intermeta.de>
In-Reply-To: <20010624161502.4D75C784C4@mail.clouddancer.com> <Pine.LNX.4.21.0106241332540.7419-100000@imladris.rielhome.conectiva>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 993409869 18163 212.34.181.4 (24 Jun 2001 19:11:09 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 24 Jun 2001 19:11:09 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

>On Sun, 24 Jun 2001, Colonel wrote:

>> It's simple.  I want the old reliable behavior back, the one I found
>> in kernels from 1.1.41 thru 2.2.14.

>And which one would that be ?   Note that there have been
>4 different VM subsystems in that time and the kernel has
>made the transition from the buffer cache to the page cache
>in that period.

I'd say, what he tries to tell you is that he does not (and I don't
for this point, either) care, which one it is or how it is implemented
or whether you're using a page, buffer or crispy chips cache, as long
as the bugger works, does not lock up, does not lose memory and does
not kill innocent processes. If you need a roach to wire to the
computer to do it, fine, tell me how to wire it and I'll start
lobbying mainboard suppliers to provide six pin sockets for roach
plugging.

Just as all VMs up to 2.2.19 do (with a few notable exceptions around
the 2.2.14-2.2.16 range). These VM problems are my biggest stop sign
to move my production boxes to 2.4.x. My 2.2.x boxes have uptimes in
the hundreds of days, my 2.0.x boxes do, too:

henning@db1 21:05 ~ > uptime
  9:05pm  up 410 days, 17:12,  1 user,  load average: 0.15, 0.03, 0.01
henning@db1 21:05 ~ > uname -an
Linux db1 2.0.37 #1 Sat Mar 13 19:41:01 MET 1999 i686 unknown

(Heck if that USV in front of the Cobalt Qube wouldn't have died, I'd
have another 440+ days uptime to boast with.)

That's the stability most of us want to see in the _stable_ kernel
series. And I fully agree with the fact that I don't want to become a
VM kernel expert just to run the bugger. =:-)

Some of us like Linux not because it's free but because it's rock
solid. Because some of us use them to run our businesses on it. If I
want uptimes in the days range, I'd use Win2k and hire a monkey to
administrate the box, because it has a nice GUI (TM).

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

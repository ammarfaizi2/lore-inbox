Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbRFENH0>; Tue, 5 Jun 2001 09:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263973AbRFENHQ>; Tue, 5 Jun 2001 09:07:16 -0400
Received: from tangens.hometree.net ([212.34.181.34]:38037 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S263246AbRFENHI>; Tue, 5 Jun 2001 09:07:08 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: TRG vger.timpanogas.org hacked
Date: Tue, 5 Jun 2001 13:07:05 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9filhp$hj$1@forge.intermeta.de>
In-Reply-To: <20010604183642.A855@vger.timpanogas.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 991746425 9422 212.34.181.4 (5 Jun 2001 13:07:05 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 5 Jun 2001 13:07:05 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> writes:

>is curious as to how these folks did this.  They exploited BIND 8.2.3

Look below.

>to get in and logs indicated that someone was using a "back door" in 
>Novell's NetWare proxy caches to perform the attack (since several 
>different servers were used as "blinds" to get in).  

There is AFAIK no known exploit to BIND 8.2.3 and I don't see why
anyone should use a "novell Netcache backdoor". If I'd want to hack
your box, I would use this:

% telnet vger.timpanogas.com 22     
Trying 207.109.151.240...
Connected to vger.timpanogas.com.
Escape character is '^]'.
SSH-1.5-1.2.27
^]
telnet> quit

Well known exploits downloadable at any of the better hacking sites.

>We are unable to determine just how they got in exactly, but they 
>kept trying and created an oops in the affected code which allowed 
>the attack to proceed.  

Come on, you can't be _that_ blind. Either you didn't install all your
vendor recommended updates or you installed self rolled programs and
got caught.

You even get connects on the telnet port (no daemon, though), so you
either have a hosts.allow (which _is_ spoofable) or a non-cleaned up
[x]inetd.conf which means you didn't harden your box for Internet
usage.

If you don't prepare your box for a hostile environment, you get
hit. First law of the Internet.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

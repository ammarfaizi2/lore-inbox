Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbRFMLRT>; Wed, 13 Jun 2001 07:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263418AbRFMLRJ>; Wed, 13 Jun 2001 07:17:09 -0400
Received: from tangens.hometree.net ([212.34.181.34]:2693 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S263152AbRFMLQ7>; Wed, 13 Jun 2001 07:16:59 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
Date: Wed, 13 Jun 2001 11:16:57 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9g7i39$d33$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.33.0106121702500.25366-100000@dlang.diginsite.com> <3B26C779.ECE9017C@candelatech.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 992431017 23814 212.34.181.4 (13 Jun 2001 11:16:57 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 13 Jun 2001 11:16:57 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

>David Lang wrote:
>> 
>> I am useing the D-link 4 port card without running into problems
>> (admittidly I have not been stressing it much yet)

>I was able to get the D-Link to work in half-duplex (100bt), but
>not in auto-negotiate or full-duplex mode.  (Packets would pass,
>but there would be huge number of carrier and other bad packets.)

Yes. Exactly my experience (with 2.2.18 / 19 / 20pre). It is simply
not possible to make a tulip based card work reliably against our
Cisco Catalyst switches in these days. Sadly, because under 2.0.x,
these were rock-solid.

So I started to use 3COM exclusively (which work perfectly with our
switches) and eepro100 if necessary (or built onboard).

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

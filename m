Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbSL3K1K>; Mon, 30 Dec 2002 05:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbSL3K1K>; Mon, 30 Dec 2002 05:27:10 -0500
Received: from mail.hometree.net ([212.34.181.120]:20395 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S266804AbSL3K1J>; Mon, 30 Dec 2002 05:27:09 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] Workaround for AMD762MPX "mouse" bug
Date: Mon, 30 Dec 2002 10:35:31 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aup7hj$gi6$1@forge.intermeta.de>
References: <20021224162501.GA5363@averell> <20021229151049.A16750@redhat.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1041244531 26734 212.34.181.4 (30 Dec 2002 10:35:31 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 30 Dec 2002 10:35:31 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@redhat.com> writes:

>On Tue, Dec 24, 2002 at 05:25:01PM +0100, Andi Kleen wrote:
>> way would be to always reserve that page, but I didn't feel like
>> punishing everybody just for a hardware bug in a single chipset.
>> 
>> Patch for 2.5.53. Please consider applying.

>That's the wrong way to do it.  Workarounds like this need to be automatic, 
>and with init code sections, there is no excuse not to.  Instead of making 
>the user pass a quirk option, why not reserve the page and then free it if 
>the errata is not present?

That's exactly what I suggested to Andi in private mail and he said
"yes, this would work". So I expect a patch doing exactly this from
him. :-)

(Yes, I could have done it myself but I have neither the chipset or am
I a deep innards kernel hacker).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

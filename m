Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262720AbRE3KqS>; Wed, 30 May 2001 06:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbRE3KqH>; Wed, 30 May 2001 06:46:07 -0400
Received: from [212.34.181.34] ([212.34.181.34]:45452 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id <S262720AbRE3Kpx>;
	Wed, 30 May 2001 06:45:53 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] net #9
Date: Wed, 30 May 2001 10:43:17 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9f2is5$kbi$1@forge.intermeta.de>
In-Reply-To: <18468.991218618@ocs3.ocs-net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 991219397 24561 212.34.181.4 (30 May 2001 10:43:17 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 30 May 2001 10:43:17 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

>On Wed, 30 May 2001 09:32:39 +0000 (UTC), 
>"Henning P. Schmiedehausen" <mailgate@hometree.net> wrote:
>>Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl> writes:
>>
>>>-static char	name[4][IFNAMSIZ] = { "", "", "", "" };
>>
>>>+static char	name[4][IFNAMSIZ];
>>
>>Ugh. Sure about that one? the variables have been pointers to zero,
>>now they're zero...

>Bzzt.  Arrays and pointers are not always equivalent.  This code

yeah, you're right. I got fooled by the fact that these are already
arrays, not initialized pointers.

There _is_ a point for Java in this. ;-) 

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

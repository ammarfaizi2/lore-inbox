Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267731AbTBRIvI>; Tue, 18 Feb 2003 03:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbTBRIvI>; Tue, 18 Feb 2003 03:51:08 -0500
Received: from mail.hometree.net ([212.34.181.120]:10686 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S267731AbTBRIvH>; Tue, 18 Feb 2003 03:51:07 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: [DEFINITELY OFF-TOPIC] Re: ADSL vs Leased line
Date: Tue, 18 Feb 2003 09:01:08 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b2ssok$v2k$2@tangens.hometree.net>
References: <20030216215008$5ac9@gated-at.bofh.it> <87adgu3ao4.fsf@deneb.enyo.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1045558868 31828 212.34.181.4 (18 Feb 2003 09:01:08 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 18 Feb 2003 09:01:08 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

>John Bradford <john@grabjohn.com> writes:

>> A leased line is guaranteed bandwidth,

>Not at all.  Welcome to the wonderful world of ATM Traffic Management.

That's the very point John was trying to make. A leased line in the
classic sense (E1/T1/ISDN) _is_ guranteed bandwith. You get 64k, 128k,
1920k, 1984k 2048k [1] guranteed, fixed bandwith synched with a master
clock.

And: bandwidth on a leased line != IP bandwidth. And with DSL lines
(which are either HDLC over copper (e.g. Lucent HST-DST) or simply
ATM-25 over copper (Cisco 14xx / Lucent Cellpipes) you can even get
both.

So your "wonderful world of ATM traffic management" is only correct
for some flavours of DSL lines.

	Regards
		Henning

Let's kill this thread. :-)

[1] 1920k = 1 slot for network management,
            1 slot for connection management, 
            30 channels data
    1984k = 1 slot for connection management,
            31 channels data (G.704)
    2048k = 32 channels data (G.703)

    A least in Germany, a "2 MBit leased line" can come in any of
    these flavours.

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTIBGxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTIBGxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:53:33 -0400
Received: from [212.34.184.41] ([212.34.184.41]:39852 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id S263578AbTIBGxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:53:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: bandwidth for bkbits.net (good news)
Date: Tue, 2 Sep 2003 06:53:09 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bj1eol$its$1@tangens.hometree.net>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1062485589 19388 212.34.184.4 (2 Sep 2003 06:53:09 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 2 Sep 2003 06:53:09 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt <der.eremit@email.de> writes:

>In a way, you're on the right end of the pipe because the system
>that does your traffic shaping is part of the general network, viewed
>from the machines behind the shaper.

Stop argueing. You can shape only outgoing packets, which means that the
shaper must have a big uplink pipe and then shape that into a thin downlink
pipe. In Larrys' case, the shaper must be on the ISP network before the T1.

Once the packets hit the T1 (or your ISDN link), you've already
lost. No matter how much shaping, dropping, non-acking you're doing on
your side of the link.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)

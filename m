Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbTIBHGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTIBHGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:06:48 -0400
Received: from [212.34.184.41] ([212.34.184.41]:13741 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id S263563AbTIBHGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:06:47 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: bandwidth for bkbits.net (good news)
Date: Tue, 2 Sep 2003 07:06:27 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bj1fhj$its$4@tangens.hometree.net>
References: <20030830230701.GA25845@work.bitmover.com> <87llt9bvtc.fsf@deneb.enyo.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1062486387 19388 212.34.184.4 (2 Sep 2003 07:06:27 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 2 Sep 2003 07:06:27 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

>do this for a T1 customer (typically, it requires "unusual"
>configuration of vital production routers with the fat pipes).

You need a shaper connected to the ISP backbone which shapes the
outgoing traffic for you and a border router which talks to the T1
(C17xx or C26xx). Normally, if your ISP has some sort of clue, you
will also need a bastion router which can handle backbone <-> 100 MBit
traffic and does dynamic routing updates (EGP or OSPF) to the ISP
backbone (A C26xx or C37xx).

This isn't your run-of-the-mill setup but I know of plenty ISPs here
that will happily sell you this and also the consulting needed to
plan, setup and operate the link. However, you won't get it for
$199/month. :-)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTIBHBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbTIBHBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:01:43 -0400
Received: from [212.34.184.41] ([212.34.184.41]:61868 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id S263583AbTIBHBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:01:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: bandwidth for bkbits.net (good news)
Date: Tue, 2 Sep 2003 07:01:21 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bj1f81$its$3@tangens.hometree.net>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1062486081 19388 212.34.184.4 (2 Sep 2003 07:01:21 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 2 Sep 2003 07:01:21 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

>> It doesn't work when you dont control incoming. As a simple extreme
>> example if I pingflood you from a fast site then no amount of shaping
>> your end of the link will help, it has to be shaped at the ISP end.

>sure, that's why I said it won't work with synflood. I just doubt the
>ping/syn floods distributed denial of services are an high percentage of

The traffic on sites like www.microsoft.com, www.kernel.org or I'd say
even www.bkbits.net isn't distinguishable from a DDoS Synflood on a
regular day. A bazillion of different IP addresses from all over the
net trying to establish a TCP connection at the same time. And the
other sides are dog-slow modem/isdn/dsl connections which means high
latency, low bandwith, many retransmits and still they're legal
connections that you want to serve.

Forget it. You can't compare your homegrown ISDN/DSL line with the
traffic of a serious internet service. If you try, you get burned.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTDEI3m (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 03:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTDEI3m (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 03:29:42 -0500
Received: from mail.hometree.net ([212.34.181.120]:15849 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S261962AbTDEI3l (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 03:29:41 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Strange e1000
Date: Sat, 5 Apr 2003 08:41:11 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b6m4r7$rp1$2@tangens.hometree.net>
References: <043501c2faaf$da061e10$3f00a8c0@witbe> <1049465969.3324.40.camel@abhilinux.cygnet.co.in> <20030404181400.GA26545@gtf.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1049532071 28449 212.34.181.4 (5 Apr 2003 08:41:11 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sat, 5 Apr 2003 08:41:11 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

>On Fri, Apr 04, 2003 at 07:49:28PM +0530, Abhishek Agrawal wrote:
>> On Fri, 2003-04-04 at 19:11, Paul Rolland wrote:
>> 
>> > Could it be possible that the 1000MBps FD on the e1000 side is
>> > a local configuration, and that it needs some time to discuss with
>> > the Netgear switch to negotiate correctly speed and duplex before
>> > working correctly ? (i.e. 20 sec = negotiation time)
>> Autoneg must be completed within 2 sec, or else it is considered as
>> failed.

>If we follow this rule, we have lots of Cisco and other network gear
>that will not be able to communicate with Linux.

2 seconds sound like "spanning-tree portfast" in Cisco-speak. 20
seconds sounds like normal configuration. Both are legal and work with
normal FE gear. It might be possible that you must deactivate
spanning-tree if you don't connect a switch.

I personally found the 20 second break always annoying so I routinely
disable it on my catalysts. :-)

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271195AbTHHKc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271196AbTHHKc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:32:26 -0400
Received: from mail.hometree.net ([212.34.181.120]:57227 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S271195AbTHHKcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:32:24 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
Date: Fri, 8 Aug 2003 10:32:23 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bgvu7n$2lj$1@tangens.hometree.net>
References: <20030807224545.A29285@google.com> <Pine.LNX.4.44.0308080850280.1466-100000@cheetah.psv.nu>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1060338743 2739 212.34.181.4 (8 Aug 2003 10:32:23 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 8 Aug 2003 10:32:23 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Svensson <petersv@psv.nu> writes:

>I have had rpm lock up on me a few times. I think it was waiting on a 
>sempahore or some other synchronization event. After killing the process 
>(after several hours) no rpm transactions could be completed, they all 
>hanged at the same point. The only way to get rpm to work again was to 
>reboot the system. 

rm -f /var/lib/rpm/__db*

This is a FAQ. And a Bug in RH9.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"You are being far too rational for this discussion."  
       --- Scott Robert Ladd in <3F1874B0.6030507@coyotegulch.com>

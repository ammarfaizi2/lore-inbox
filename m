Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTIEPu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTIEPu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:50:27 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:21778 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S264256AbTIEPuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:50:19 -0400
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
References: <20030830230701.GA25845@work.bitmover.com>
	<87llt9bvtc.fsf@deneb.enyo.de> <bj1fhj$its$4@tangens.hometree.net>
	<874qzrsljc.fsf@deneb.enyo.de>
	<1062776157.20632.1697.camel@forge.intermeta.de>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Henning Schmiedehausen <hps@intermeta.de>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 05 Sep 2003 17:50:04 +0200
In-Reply-To: <1062776157.20632.1697.camel@forge.intermeta.de> (Henning
 Schmiedehausen's message of "05 Sep 2003 17:35:57 +0200")
Message-ID: <871xuvqloz.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning Schmiedehausen <hps@intermeta.de> writes:

>> Yes, I snipped the DoS context, and your approach would work in a
>> benign environment. 8-)
>
> 225kpps * 64 Bytes (minimum packet len) = 13,7 MBytes / sec
>
> 100 MBit / 8 bit = 12,5 MBytes / sec
>
> So, IMHO even with a small packet saturated 100 MBit link you won't
> reach 225kpps. AFAIK this was Ciscos intention to publish this number.
> It basically says "you will have filled your link before you fill our
> router". 

Cisco sells Gigabit Ethernet linecards for this router, and the
situation is quite different in this case.  And with most attacks,
it's a futile exercise to try to combat them on a Fast Ethernet link,
anyway. 8-(

> But I'm pretty sure that a C37xx would handle full 100 MBit traffic to a
> busy website without any problems. In fact, I know that it does. ;-) (We
> did switch to a C12000 shortly after, mainly because we went Gigabit).

Of course it does.  After all, web traffic is somewhat different from
pure DoS traffic. 8-)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbTALW2J>; Sun, 12 Jan 2003 17:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTALW2I>; Sun, 12 Jan 2003 17:28:08 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.9]:35789 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267571AbTALW2G>; Sun, 12 Jan 2003 17:28:06 -0500
Date: Sun, 12 Jan 2003 17:34:58 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <20030112221802.GN31238@vitelus.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
 <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
 <20030112214937.GM31238@vitelus.com>
 <1042409239.3162.136.camel@RobsPC.RobertWilkens.com>
 <20030112221802.GN31238@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 17:18, Aaron Lehmann wrote:
> These are usually error conditions. If you inline them, you will have
> to jump *over* them as part of the normal code path. You don't save

You're wrong.  You wouldn't have to jump over them any more than you
have to jump over the "goto" statement.  They would be where the goto
statement is.  Instead of the goto you would have the function.

> any instructions, and you end up with a kernel which has much more
> duplicated code and thus thrashes the cache more. It also makes the

If that argument was taken to it's logical conclusion (and I did, in my
mind just now), no one should add any code the grows the kernel at all.

-Rob


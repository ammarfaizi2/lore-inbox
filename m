Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTALWoO>; Sun, 12 Jan 2003 17:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTALWoN>; Sun, 12 Jan 2003 17:44:13 -0500
Received: from vitelus.com ([64.81.243.207]:16145 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S267608AbTALWoM>;
	Sun, 12 Jan 2003 17:44:12 -0500
Date: Sun, 12 Jan 2003 14:52:28 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Rob Wilkens <robw@optonline.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112225228.GP31238@vitelus.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com> <1042407845.3162.131.camel@RobsPC.RobertWilkens.com> <20030112214937.GM31238@vitelus.com> <1042409239.3162.136.camel@RobsPC.RobertWilkens.com> <20030112221802.GN31238@vitelus.com> <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 05:34:58PM -0500, Rob Wilkens wrote:
> You're wrong.  You wouldn't have to jump over them any more than you
> have to jump over the "goto" statement.

The goto is a conditional jump. You propose replacing it with a
conditional jump past the error handling code predicated on the
opposite condition. Where's the improvement?

> > any instructions, and you end up with a kernel which has much more
> > duplicated code and thus thrashes the cache more. It also makes the
> 
> If that argument was taken to it's logical conclusion (and I did, in my
> mind just now), no one should add any code the grows the kernel at all.

Not without good reason.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWHCSfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWHCSfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWHCSfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:35:15 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:18194 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1030183AbWHCSfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:35:12 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: "Michael Chan" <mchan@broadcom.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
cc: tytso@mit.edu, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
In-Reply-To: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
References: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
Date: Thu, 03 Aug 2006 11:36:47 -0700
Message-ID: <1154630207.3117.17.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006080306; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230312E34344432343135432E303032372D422D2F342B574C684A754433704B705975633943514C71513D3D;
 ENG=IBF; TS=20060803183503; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006080306_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68CC9E5E0X8873239-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 20:00 +1000, Herbert Xu wrote:
> Theodore Tso <tytso@mit.edu> wrote:
> > 
> > I'm sending this on mostly because it was a bit of a pain to track down,
> > and hopefully it will save time if anyone else hits this while playing
> > with the -rt kernel.  It is NOT the right way to fix things, so please
> > don't even think of applying this patch (unless you need it, in your own
> > local tree :-).
> > 
> > One of these days when we have time to breath we'll look into fixing
> > this the right way, if someone doesn't beat us to it first.  :-)
> 
Ted, what tg3 hardware is having this timer related problem?  Can you
send me the tg3 probing output?


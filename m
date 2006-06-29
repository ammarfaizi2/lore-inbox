Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933076AbWF2Wtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076AbWF2Wtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933075AbWF2Wtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:49:32 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:40970 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S933072AbWF2Wtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:49:31 -0400
Date: Fri, 30 Jun 2006 08:50:39 +1000
From: CaT <cat@zip.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17.1: fails to fully get webpage
Message-ID: <20060629225039.GO2149@zip.com.au>
References: <20060629015915.GH2149@zip.com.au> <20060628.194627.74748190.davem@davemloft.net> <20060629030923.GI2149@zip.com.au> <20060628.204709.41634813.davem@davemloft.net> <20060629041827.GJ2149@zip.com.au> <44A3E898.1020202@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A3E898.1020202@tmr.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 10:50:00AM -0400, Bill Davidsen wrote:
> >Basically the mostlikely end-result is I don't know what there is a
> >problem and my customer doesn't know that there is a problem but they're
> >just not getting as many hits to their site that they otherwise would.
> >
> >Ofcourse, this all depends if such a situation is possible. If it is
> >possible would it affect dns and mail in a similar manner too?
> >
> I'm glad David Miller clarified this, because I was about to send a 
> "don't do that" followup ;-)

:) I don't know how I got the wrong config option to modify but there
you go. :)

> But your example is misleading, or at least doesn't reflect customers I 
> know. While a few clients with broken network connections may be 
> unhappy, disabling scaling will make your web server really, really, 
> slow, and that will make everyone unhappy. Particularly if the web 
> content is flash or 2MB jpegs, or other ill-chosen stuff. You don't want 
> people to think you are running at dial-up speeds.

Which would be why I wont move from 2.6.16.x for my servers unless I
really, really, really have to. I don't know how many broken sites are
out there and I cannot tell.

Another datapoint to this is that I've had this my netcat web test
running since 8:42pm yesterday. It's 8:37am now. It hasn't progressed
in any way. It hasn't quit. It hasn't timed out. It just sits there,
hung. This leads me to consider the possibility of a DOS, either
intentional or accidental (think about 2.6.17.x running on a mail server
and someone mails/spams from a broken place).

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby

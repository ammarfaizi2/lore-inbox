Return-Path: <linux-kernel-owner+w=401wt.eu-S1751588AbXAVKqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXAVKqy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXAVKqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:46:54 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:31077 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751580AbXAVKqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:46:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BOdJHgGwJPju2SOSxzs+0a0tTEE1dqPdcRyi1iAh6/wdRDPF3Ve5zeE4My+mrCgY+V1wqHrP7mZ8DHKTOfh8vlie9Q4Juie5hYkwx8yBVNlv7S+MLvwuf/j8FSWKj0wOx0xDKwJsTjq/ps1+2vxHSMtGOLgOrJuZ961YTK9Moyo=  ;
X-YMail-OSG: 4UmEstAVM1mcOseTWbvuE1PUtlL2DuxhnWdvr2A0m4D.JTjaNu4fbjYdSoGoXLwpDfTshEKcgGcCDxts9nEhJ5UVk_omblzolscZK_LaA6Wkm8p5ljxAmL0IUDqc.xc-
Message-ID: <45B495F9.4@yahoo.com.au>
Date: Mon, 22 Jan 2007 21:46:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Nicholas Miell <nmiell@comcast.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6> <1169401892.2999.1.camel@entropy> <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:

> by adding (temporarily) the definitions of TRUE and FALSE to types.h,
> you should then (theoretically) be able to delete over 100 instances
> of those same macros being *defined* throughout the source tree.
> you're not going to be deleting the hundreds and hundreds of *uses* of
> TRUE and FALSE (not yet, anyway) but, at the very least, by adding two
> lines to types.h, you can delete all those redundant *definitions* and
> make sure that nothing breaks.  (it shouldn't, of course, but it's
> always nice to be sure.)

Doesn't seem very worthwhile, and it legitimises this definition we're
trying to get rid of.

> *now*, once that's done, you can start going through the tree and
> doing the conversion from upper case to lower case, little by little,
> subsystem by subsystem.

I don't see why your patch is needed before the individual conversions?

> the predictable response will be, "you really should do that all at
> once."

You don't need to do it all at once.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

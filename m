Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbRCOEBS>; Wed, 14 Mar 2001 23:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbRCOEBI>; Wed, 14 Mar 2001 23:01:08 -0500
Received: from web11804.mail.yahoo.com ([216.136.172.158]:27654 "HELO
	web11804.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131629AbRCOEAy>; Wed, 14 Mar 2001 23:00:54 -0500
Message-ID: <20010315040013.28464.qmail@web11804.mail.yahoo.com>
Date: Wed, 14 Mar 2001 20:00:13 -0800 (PST)
From: Jeffrey Butler <jeffreymbutler@yahoo.com>
Subject: Re: poll() behaves differently in Linux 2.4.1 vs. Linux 2.2.14 (POLLHUP)
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru, davem@redhat.COM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexy wrote:
>> Damn, we did not test behaviour on absolutely new
>> clean never connected socket... Solaris really may
>> return 0 on it.
>>
>> However, looking from other hand the issue looks as
>> absolutely academic and not related to practice in
>> any way.

Hi,
  I'm not sure this issue is really that academic.  In
fact, it's one of those nitty-gritty, annoying details
that academics tend to ignore :).  Anyway, I'm looking
at this from a very pragmatic standpoint.  I'd like to
minimize the complexity and the number of special
cases when trying to support an application on several
different platforms.  If other popular Unix OS's
behave this way I definely understand the reasoning,
but it seems that at least Solaris 7 does not... 
Sure, workarounds exist, but they just complicates
things.

-jeff

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/

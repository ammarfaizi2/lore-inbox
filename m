Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263496AbRFHOL1>; Fri, 8 Jun 2001 10:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263747AbRFHOLR>; Fri, 8 Jun 2001 10:11:17 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:52498 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S263496AbRFHOLI>; Fri, 8 Jun 2001 10:11:08 -0400
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: xircom_cb problems
Message-ID: <992009463.3b20dcf7467ab@eargle.com>
Date: Fri, 08 Jun 2001 10:11:03 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
In-Reply-To: <Pine.LNX.4.33.0106071322160.22593-100000@age.cs.columbia.edu>
In-Reply-To: <Pine.LNX.4.33.0106071322160.22593-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Both of these are slow, actually. I'm getting 7.5-8MB/s when receiving
> from a 100Mbit box (tulip or starfire, doesn't seem to matter). 
> Transmitting is still slow for me, but that is most likely a different 
> problem -- and I'm looking into it.

Yeah, I knew they were both slow, but at least one is acceptable, the <200KB/s
is below usable when doing any network based work.

> Moreover, I'm getting 9+MB/s in both directions when using the other 
> driver (xircom_tulip_cb), patched to do half-duplex only. So the card
> can definitely transfer at network speeds.

I'm not doing nearly as well with the other driver, but I don't have it patched
for half-duplex only.  I tried setting the remote end to force half-duplex but
this didn't seem to work quite right.


> Looking forward to seeing them...

OK, I tried your patch, it did fix the problem where pump wouldn't pull an IP
address, but I'm still having the problem where my ping times go nuts.  I've
attached an example, it's 100% repeatable on my network at work.  It was so bad
I couldn't get any benchmark numbers.

Later,
Tom


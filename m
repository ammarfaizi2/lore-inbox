Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262475AbREXWyH>; Thu, 24 May 2001 18:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262476AbREXWx5>; Thu, 24 May 2001 18:53:57 -0400
Received: from team.iglou.com ([192.107.41.45]:45263 "EHLO iglou.com")
	by vger.kernel.org with ESMTP id <S262475AbREXWxt>;
	Thu, 24 May 2001 18:53:49 -0400
Date: Thu, 24 May 2001 18:53:34 -0400
From: Jeff Mcadams <jeffm@iglou.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org
Subject: Re: SyncPPP Generic PPP merge
Message-ID: <20010524185333.B7667@iglou.com>
In-Reply-To: <002501c0e48f$ffed1e40$0c00a8c0@diemos> <E1533Ra-0005hC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E1533Ra-0005hC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 24, 2001 at 11:18:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Alan Cox
>> Instead of using ifconfig to bring an interface up or down, the user
>> must now work with pppd. And the net device naming changes (allocated
>> by ppp_generic.c instead of using the net device allocated by low
>> level driver).

>I suspect that bit can be fixed if need be. Its nice to keep a constant
>naming between cisco/ppp modes. cisco/ppp autodetect is also possible
>and would be rather nice to support 

Indeed.  And let me just throw out another thought.  A clean abstraction
of the various portions of the PPP functionality is beneficial in other
ways.  My personal pet project being to add L2TP support to the kernel
eventually.  A good abstraction of the framing capabilities and basic
PPP processing would be rather useful in that project.

>> Or is it to *add* generic PPP support to syncppp, leaving (at least
>> temporarily) the existing PPP capability in syncppp for
>> compatibility?  (implying a new syncppp flag USE_GENERIC_PPP?)

>Assuming this is a 'when 2.5 starts' discussion I'd like initially to
>keep the syncppp api is but the pppd code going via generic ppp - and
>yes it would break configs.

>Clearly thats not 2.4 acceptable

I would agree that such a project would be 2.5 material.

I'll try to keep up with things on the list, but if this goes off-list,
I would appreciate being kept in the loop if possible.  :)  Thanks!
-- 
Jeff McAdams                            Email: jeffm@iglou.com
Head Network Administrator              Voice: (502) 966-3848
IgLou Internet Services                        (800) 436-4456

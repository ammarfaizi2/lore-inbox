Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTA2ODp>; Wed, 29 Jan 2003 09:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbTA2ODp>; Wed, 29 Jan 2003 09:03:45 -0500
Received: from taz.cerebus.com ([208.254.26.145]:31970 "EHLO taz.cerebus.com")
	by vger.kernel.org with ESMTP id <S266038AbTA2ODn>;
	Wed, 29 Jan 2003 09:03:43 -0500
Date: Wed, 29 Jan 2003 09:12:54 -0500 (EST)
From: David C Niemi <lkernel2003@tuxers.net>
To: "David S. Miller" <davem@redhat.com>
cc: kuznet@ms2.inr.ac.ru, <benoit-lists@fb12.de>, <dada1@cosmosbay.com>,
       <cgf@redhat.com>, <andersg@0x63.nu>, <lkernel2003@tuxers.net>,
       <linux-kernel@vger.kernel.org>, <tobi@tobi.nu>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
In-Reply-To: <20030128.160806.13210372.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0301290904060.7848-100000@harappa.oldtrail.reston.va.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Jan 2003, David S. Miller wrote:
>    From: kuznet@ms2.inr.ac.ru
>    Date: Wed, 29 Jan 2003 02:56:41 +0300 (MSK)
>
>    Hey! Interesting thing has just happened, it is the first time when I 
>    found the bug formulating a senstence while writing e-mail not while 
>    peering to code. :-)
> 
> Congratulations :-)

Just to confirm, this fix works for me as well.

...
> Indeed, this bug exists in 2.4 as well of course.
> 
> This bug is 2.4.3 vintage :-)  It got added as part of initial
> zerocopy merge in fact.

Odd, then, that it I was unable to reproduce the SSH hangs under 2.4.18
even once, despite heavily using it for several days under the same
circumstances.  Is there any reason 2.4.x would be better able to recover?  
2.5.59 with the fix seems to feel a bit less balky than 2.4.18 without the
fix, so it seemed to me that 2.4.18 had some way of recovering at the cost
of a several second pause in the session.

DCN



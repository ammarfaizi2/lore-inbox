Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRDXIby>; Tue, 24 Apr 2001 04:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRDXIbo>; Tue, 24 Apr 2001 04:31:44 -0400
Received: from zmailer.org ([194.252.70.162]:22027 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131446AbRDXIbc>;
	Tue, 24 Apr 2001 04:31:32 -0400
Date: Tue, 24 Apr 2001 11:31:10 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Paolo Castagna <castagna@cefriel.it>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [help] TCP rate control and Linux TCP/IP Stack?
Message-ID: <20010424113110.Y805@mea-ext.zmailer.org>
In-Reply-To: <76D2776C1B442B4C90E1F95FCA217C46866D65@roll.cefriel.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76D2776C1B442B4C90E1F95FCA217C46866D65@roll.cefriel.it>; from castagna@cefriel.it on Tue, Apr 24, 2001 at 10:11:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 10:11:15AM +0200, Paolo Castagna wrote:
> Hi,
> I'm an Italian student and I'm doing a Master Thesis on TCP rate 
> control.

   You have already posted this very same message to
        linux-net@vger.kernel.org
   and:
        netdev@oss.sgi.com
   lists.  If you don't get reply from those (netdev mainly), the
   linux-kernel is not going to yield cheers either.

   People that know the networking code intimately are presently
   "somewhat" busy,   Be patient, repeat this topic at  netdev
   list after about a week.

....
> ---------------------------------------------------------------------
> About this algorithm, I've a problem... how can I measure the rate
> Ri for each TCP flow? I've found NeTraMet on this URL:
> http://www.auckland.ac.nz/net/Accounting/ntm.Release.note.html
> ... and I've also read the discussion about that on linux-kernel 
> mailing list. Where is the best place to make a such thing? 
> I've thought in /net/core/dev.c in function dev_queue_xmit. 
> And, again, how can I associate the rate Ri to each TCP flow?

        TCP Timestamps ?
        (Which Linux does use if the other end supports them too.)

        Of course, what is "rate" ?  Units of something per units
	of time ?  Packets ?  Payload bytes ?   How does the size
        of payload data in the packets affect the "rate" ?

...
> Greetings,
> Paolo Castagna.

/Matti Aarnio

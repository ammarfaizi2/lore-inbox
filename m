Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160146AbQG2AhI>; Fri, 28 Jul 2000 20:37:08 -0400
Received: by vger.rutgers.edu id <S157629AbQG2Aey>; Fri, 28 Jul 2000 20:34:54 -0400
Received: from smtp.networkusa.net ([216.15.144.12]:14456 "EHLO smtp.networkusa.net") by vger.rutgers.edu with ESMTP id <S157371AbQG2Ach>; Fri, 28 Jul 2000 20:32:37 -0400
Date: Fri, 28 Jul 2000 19:51:45 -0500
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Message-ID: <20000728195145.A23126@thune.mrc-home.org>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.rutgers.edu
References: <200007272122.RAA04791@tsx-prime.MIT.EDU> <m2hf9bnm95.fsf@euler.axel.nom> <20000728162225.A4317@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <20000728162225.A4317@saw.sw.com.sg>; from saw@saw.sw.com.sg on Fri, Jul 28, 2000 at 04:22:25PM +0800
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, Jul 28, 2000 at 04:22:25PM +0800, Andrey Savochkin wrote:
> I've been using exactly this layout for years.
> Moreover, sometimes I keep a lot of kernels of the same version with some
> differences in the code, so I give the directories self-speaking names (not
> just $(uname -r)) and never have chances to use wrong modules or System.map.

I've been thinking about this for a while now.  I'd love to be able to
build and distribute from a single point a variety of kernels/modules and
have things installed into various locations.  Ie, I'd like to enhance the
KERNELRELEASE stuff to also include something like LOCALINFO.

I can't use EXTRAVERSION because it's often in use (ie, pre17).

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131277AbRCHGEV>; Thu, 8 Mar 2001 01:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131281AbRCHGEN>; Thu, 8 Mar 2001 01:04:13 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:26635 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S131277AbRCHGDz>;
	Thu, 8 Mar 2001 01:03:55 -0500
Message-ID: <3AA7276B.DB9AEC11@candelatech.com>
Date: Wed, 07 Mar 2001 23:32:11 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ?(No
In-Reply-To: <Pine.GSO.4.21.0103080027150.5588-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 7 Mar 2001, Ben Greear wrote:
> 
> > However, messing with the hdparms options can do random things, at
> > least from my perspective as a user:  It may bring exciting new performance
> > to your system, and it may subtly, or not so, corrupt your file system.
> 
> It's root-only. If you run unfamiliar stuff as root without thorough
> RTFM or choose to ignore "use with extreme caution" contained in the
> manpage - hdparm is the least of your problems. Think of it as evolution
> in action...
>                                                         Cheers,
>                                                                 Al

I see it differently:  If it's possible for the driver to protect the
user, and it does not, then it strikes me as irresponsible programming.  If
there is a reason other than 'only elite users are cool enough to tune
their system, and they never make mistakes', then that's ok, but I have
not heard that argument yet.

Of course, I'd love it if the HD driver automatically brought it over
4MBps (it's 7200 RPM, for goodness sake!!).  (It sounds like, from
reading the hdparm man page, that my HD should do at least 20MBps..)

Either way, I've said my piece, and will go back to wrestling with
why my network/overall performance is sucking so badly all of a sudden...

Enjoy,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear

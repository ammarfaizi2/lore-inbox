Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276641AbRJ2RQw>; Mon, 29 Oct 2001 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJ2RQo>; Mon, 29 Oct 2001 12:16:44 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:16770 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S276641AbRJ2RP4>;
	Mon, 29 Oct 2001 12:15:56 -0500
Message-ID: <3BDD8EEC.6DFE6BA5@candelatech.com>
Date: Mon, 29 Oct 2001 10:16:28 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jurgen Botz <jurgen@botz.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100.c & Intel integrated MBs
In-Reply-To: <11361.1004374395@nova.botz.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Botz wrote:

> I'm now using the e100 driver from the Intel web site, which works
> perfectly, and light testing shows the Scyld (Don Becker) driver
> to work as well.  The Intel driver seems to have an incompatible
> license (noxious advertising clause?), but the Scyld drivers don't...
> at least there isn't any license mentioned and of course many
> of the net drivers in the current kernel are just earlier versions
> of the Scyld drivers.

The Scyld drivers have only recently started working with the 2.4 series,
and there is some unholly war between Becker and the rest of the kernel
hackers...so I don't think you'll ever see his drivers in the standard
kernel again...  RH usually tries to load the e100 (Intel's driver)
instead of the eepro100.  The e100's license is close to compatible
with the kernel, and I've heard rumors that the remaining issues may
be worked out...  I've also heard the code is ugly as hell...but it
does seem to work.  If only the e100 supported MII IOCTLs then I'd
use it all the time!

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275713AbRI0AGH>; Wed, 26 Sep 2001 20:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275712AbRI0AF5>; Wed, 26 Sep 2001 20:05:57 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:9195 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S275707AbRI0AFw>;
	Wed, 26 Sep 2001 20:05:52 -0400
Message-ID: <3BB26D72.69E02ED0@candelatech.com>
Date: Wed, 26 Sep 2001 17:06:10 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Sandstrom <peter@zaphod.nu>
CC: Robert Cantu <robert@tux.cs.ou.edu>, linux-kernel@vger.kernel.org
Subject: Re: Question: Etherenet Link Detection
In-Reply-To: <CIEJKOKMAIAHDBBLFGFFEEOPCGAA.peter@zaphod.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Sandstrom wrote:
> 
> I know for sure that the Intel 82559 Fast Ethernet embedded controller
> has a register where it's possible to read out if the link led is active
> or not. It seems quite likely that this would be available on other
> controllers as well.
> 
> Is there any functionality in the current kernel that enables a userland
> program to read this? I mostly turn my machines on and and let them do
> their thing until the hardware fails :)
> 
> /Peter

You can get this information out of any NIC that supports
the mii-diag protocols.  The two I've used are the eepro100
and tulip drivers...

You can read Becker's mii-diag source for the gory details!

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbREFHBG>; Sun, 6 May 2001 03:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133024AbREFHAq>; Sun, 6 May 2001 03:00:46 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:58628 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S133019AbREFHAn>;
	Sun, 6 May 2001 03:00:43 -0400
Message-ID: <3AF4FB57.BA55A651@candelatech.com>
Date: Sun, 06 May 2001 00:20:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <3AF4720F.35574FDD@candelatech.com>
		<15092.32371.139915.110859@pizda.ninka.net>
		<3AF49617.1B3C48AF@candelatech.com> <15092.37426.648280.631914@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Ben Greear writes:
>  > No idea, haven't tried to use netfilter.  With this patch, though,
>  > it's as easy as:
> 
> I know, the problem is if some existing facility can be made
> to do it, I'd rather it be done that way.

Would requiring netfilter to be used slow down the fast path
for packets in any way?  The current arp-filter code will not,
as far as I can tell, and if the netfilter overhead is significant,
that may be a good reason to accept the patch, or the alternative
one proposed a few mails back...

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

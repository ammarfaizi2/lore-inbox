Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272150AbRHXPpm>; Fri, 24 Aug 2001 11:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272183AbRHXPpc>; Fri, 24 Aug 2001 11:45:32 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:56242 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S272190AbRHXPpU>;
	Fri, 24 Aug 2001 11:45:20 -0400
Message-ID: <3B86769D.17A979D7@candelatech.com>
Date: Fri, 24 Aug 2001 08:45:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Bernhard Busch <bbusch@biochem.mpg.de>, linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel> <oupg0ahmv2a.fsf@pigdrop.muc.suse.de> <3B867096.3A1D7DE@candelatech.com> <20010824172256.A2531@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Fri, Aug 24, 2001 at 08:19:50AM -0700, Ben Greear wrote:
> > Couldn't the bonding code be made to distribute pkts to one interface or
> > another based on a hash of the sending IP port or something?  Seems like that
> > would fix the reordering problem for IP packets....  It wouldn't help for
> > a single stream, but I'm guessing the real world problem involves many streams,
> > which on average should hash such that the load is balanced...
> 
> It could, but then it is already implemented in a better way in multipath
> routing and I see no reason to duplicate the functionality.
> 

On the surface, multi-path routing sounds complicated to me, while
layer-2 bonding seems relatively trivial to set up/administer.  Since we do
support bonding, if it's a simple fix to make it better, we
might as well do that, eh?

I haven't used either, so this is just idle supposition on my part...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear

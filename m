Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270773AbRHXPXI>; Fri, 24 Aug 2001 11:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272136AbRHXPW6>; Fri, 24 Aug 2001 11:22:58 -0400
Received: from ns.suse.de ([213.95.15.193]:65287 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272122AbRHXPWq>;
	Fri, 24 Aug 2001 11:22:46 -0400
Date: Fri, 24 Aug 2001 17:22:56 +0200
From: Andi Kleen <ak@suse.de>
To: Ben Greear <greearb@candelatech.com>
Cc: Andi Kleen <ak@suse.de>, Bernhard Busch <bbusch@biochem.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
Message-ID: <20010824172256.A2531@gruyere.muc.suse.de>
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel> <oupg0ahmv2a.fsf@pigdrop.muc.suse.de> <3B867096.3A1D7DE@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B867096.3A1D7DE@candelatech.com>; from greearb@candelatech.com on Fri, Aug 24, 2001 at 08:19:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 08:19:50AM -0700, Ben Greear wrote:
> Couldn't the bonding code be made to distribute pkts to one interface or
> another based on a hash of the sending IP port or something?  Seems like that
> would fix the reordering problem for IP packets....  It wouldn't help for
> a single stream, but I'm guessing the real world problem involves many streams,
> which on average should hash such that the load is balanced...

It could, but then it is already implemented in a better way in multipath 
routing and I see no reason to duplicate the functionality.

-Andi

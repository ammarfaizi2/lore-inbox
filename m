Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTF0WWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbTF0WWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:22:46 -0400
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:35009 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id S264846AbTF0WWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:22:43 -0400
Message-ID: <3EFCC6EE.3020106@candelatech.com>
Date: Fri, 27 Jun 2003 15:36:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: davidel@xmailserver.org, mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
References: <3EFCBD12.3070101@candelatech.com>	<20030627.145456.115915594.davem@redhat.com>	<3EFCC1EB.2070904@candelatech.com> <20030627.151906.102571486.davem@redhat.com>
In-Reply-To: <20030627.151906.102571486.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Fri, 27 Jun 2003 15:15:07 -0700
> 
>    Forcing people to continue to retransmit the same report just pisses
>    people off, and in the end will get you less useful reports than if
>    you had flagged the report as 'please-gimme-more-info'.
> 
> And this is different from patch submission in what way?

It wouldn't bother me to have a list of all patches submitted either,
it would keep folks from re-implementing the same thing from time to
time.  However, the main difference is that having to cary patches
forward is a constant drag on the person with the patch that was not
accepted, so they are constantly aware of how nice it would be to
get it included..thus they may keep trying.

A user with a PCMCIA NIC that reorders packets can get another NIC, so
that bug will never re-transmitted, and it will never get fixed.  What
is worse, new users of that busted NIC will have to re-discover that all
over for themselves, because there is no bug database to search.

> 
>    Perhaps, but it's also possible that you are being a stubborn SOB
>    because you fear change :)
>    
> Absolutely not, in fact I'm daily looking for ways to change how
> I work with people who help me so that I scale better.  And I know
> for sure that a bug datamase with shit that accumulates in it
> that _REQUIRES_ me to do something about it to make it go away
> does not help me scale.
> 
> Bugme was an absolute burdon for me.
> 
> For something to scale, it must continute to operate just as
> efficiently if I were to go away for a few weeks.  The lists have that
> quality, the bug database with owner does not.

So, you'd be happy so long as bugz sent mail to the netdev mailing lists
instead of to you?


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear



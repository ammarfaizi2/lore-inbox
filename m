Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTF1AGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbTF1AGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:06:13 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:34760 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264981AbTF1AGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:06:05 -0400
Date: Fri, 27 Jun 2003 17:19:54 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, davidel@xmailserver.org, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030628001954.GD18676@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, greearb@candelatech.com,
	davidel@xmailserver.org, mbligh@aracnet.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
References: <3EFCC1EB.2070904@candelatech.com> <20030627.151906.102571486.davem@redhat.com> <3EFCC6EE.3020106@candelatech.com> <20030627.170022.74744550.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627.170022.74744550.davem@redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 05:00:22PM -0700, David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Fri, 27 Jun 2003 15:36:30 -0700
>    
>    So, you'd be happy so long as bugz sent mail to the netdev mailing
>    lists instead of to you?
> 
> The best power I have to scale is the delete key in my email
> reader, when I delete an email it's gone and that's it.
> 
> bugme bugs don't have this attribute, they are like emails that
> persist forever until someone does something about them, and this is
> the big problem I have with it.

I've proposed this before and nobody listened but maybe this time...

I think what you want is a bug database which distinguishes between
filed bugs and reviewed bugs.  You want to capture all bug reports, 
as Alan says (he's right, there is no question about it, you need to
capture the data).  You also want an *automatic* way for bugs to just
rot.  Anyone can file a bug but unless someone with expertise in the 
area reviews the bug and agrees to do something about it, the bug rots.

It's level 1 (capture) and level 2 (we really need to do something about
this some day).  Level 1 will have zillions of duplicates and tons of 
other noise.  Level 2 should be a small list, no duplicates, carefully
managed.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

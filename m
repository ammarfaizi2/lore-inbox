Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRKOSSH>; Thu, 15 Nov 2001 13:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280976AbRKOSR5>; Thu, 15 Nov 2001 13:17:57 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21214 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280971AbRKOSRk>; Thu, 15 Nov 2001 13:17:40 -0500
Date: Thu, 15 Nov 2001 10:11:41 -0800
From: Brian Beattie <alchemy@us.ibm.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changed message for GPLONLY symbols
Message-ID: <20011115101137.B1518@w-beattie1.des.beaverton.ibm.com>
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Nov 13, 2001 at 01:50:09PM +1100, Keith Owens wrote:
> When insmod detects a non-GPL module with unresolved symbols it
> currently says:
> 
> Note: modules without a GPL compatible license cannot use GPLONLY_ symbols
> 
> I thought that hint was self-explanatory, obviously it was not clear.
> Never underestimate the ability of lusers to misread a message.  insmod
> 2.4.12 will say
> 
> Hint: You are trying to load a module without a GPL compatible license
	and it has unresolved symbols.  This is probably due to a
        coding or configuration problem.  Contact the module supplier
        for assistance.

Since the attempt by an non-GPL module to use GPLONLY sysbols is a
coding error IMHO, this message is clearer and avoids the confusion we
have been seeing.

>       and it has unresolved symbols.  The module may be trying to access
>       GPLONLY symbols but the problem is more likely to be a coding or
>       user error.  Contact the module supplier for assistance.
> 
> Does anyone think that this message can be misunderstood by anybody
> with the "intelligence" of the normal Windoze user?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

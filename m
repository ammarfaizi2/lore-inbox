Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTBBH0P>; Sun, 2 Feb 2003 02:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTBBH0P>; Sun, 2 Feb 2003 02:26:15 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:49858 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S265134AbTBBH0O>; Sun, 2 Feb 2003 02:26:14 -0500
Date: Sun, 2 Feb 2003 00:35:42 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Venkat Raghu <venkatraghu2002@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: fibre channel driver
In-Reply-To: <20030131222954.18430.qmail@web40005.mail.yahoo.com>
Message-ID: <Pine.LNX.4.51.0302020032440.6018@skuld.mtroyal.ab.ca>
References: <20030131222954.18430.qmail@web40005.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2003, Venkat Raghu wrote:

> Hi,
> 
> I want to know if there is any fibrechannel driver 
> in linux kernel. If yes please point me to the source
> and any links to it. What about qlogic fibre channel
> driver. Is it part of linux community also, if so 
> where can I get it.

I'm unsure about community drivers but...

qlogic does have driver source available on their site for the qla2200 and
qla2300 which does include fail over code.  The 6.03 is
also supported under Red Hat AS2.1 and Suse 7.? or 8 by EMC, perhaps
even using RH 7.? at sometime in the near future.

I have tried it and it does work very well, although the timeout for
failover is hard coded and there may be an issue with tape drives if
failover is enabled...  I'll know more about that later this coming week.

REgards
James Bourne
> 
> 
> Please mail me at venkatraghu2002@yahoo.com.
> Regards
> Raghu
> 
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."


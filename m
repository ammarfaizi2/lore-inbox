Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136430AbREDPnu>; Fri, 4 May 2001 11:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136432AbREDPnl>; Fri, 4 May 2001 11:43:41 -0400
Received: from srv01s4.cas.org ([134.243.50.9]:36005 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S136430AbREDPn2>;
	Fri, 4 May 2001 11:43:28 -0400
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200105041543.LAA17264@mah21awu.cas.org>
Subject: Re: close()
To: washer@us.ibm.com (James Washer)
Date: Fri, 4 May 2001 11:43:18 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF9A886AE5.01B7651A-ON88256A42.0053B697@LocalDomain> from "James Washer" at May 04, 2001 08:15:59 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> What kind of file was it close()ing?
>  - jim

Ah, good question. I should have specified this. It is a socket that is
being closed, not a regular file (the socket has nonblocking set).

> p.s. Are you familiar with the strace(1) utility? It might help you get
> more information the next time this happens... especially the "-p pid"
> option.

I didn't think about this. I'll give this a whirl next time.

/Mike

> 
> 
> Mike Harrold <mharrold@cas.org>@vger.kernel.org on 05/04/2001 07:44:53 AM
> 
> Sent by:  linux-kernel-owner@vger.kernel.org
> 
> 
> To:   linux-kernel@vger.kernel.org
> cc:
> Subject:  close()
> 
> 
> 
> Hi,
> 
> We have a server which runs on a machine that now runs the new 2.4 kernel.
> Since upgrading we've seen periods where it seems to just hang for minutes
> at a time (anywhere form 5 minutes to an hour). I was finally able to get
> a core dump of the server during one of these periods and it appears that
> the hang is occuring during a call to close().
> 
> Has anyone else seen anything like this? Kernel version is:
> 
>   Linux version 2.4.2-4GB (root@Pentium.suse.de)
> 
> Thanks,
> 
> /Mike
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> 


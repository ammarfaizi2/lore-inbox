Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270236AbRHQSvd>; Fri, 17 Aug 2001 14:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270412AbRHQSvX>; Fri, 17 Aug 2001 14:51:23 -0400
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:55457 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270236AbRHQSvS>; Fri, 17 Aug 2001 14:51:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Adrian Cox <adrian@humboldt.co.uk>, root@chaos.analogic.com
Subject: Re: Encrypted Swap
Date: Fri, 17 Aug 2001 11:51:08 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010817130849.2216A-100000@chaos.analogic.com> <3B7D5603.8080805@humboldt.co.uk>
In-Reply-To: <3B7D5603.8080805@humboldt.co.uk>
MIME-Version: 1.0
Message-Id: <01081711510800.00814@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 August 2001 10:36 am, Adrian Cox wrote:
> Richard B. Johnson wrote:
> > ** At this instant, you just killed everything in RAM with precharge
> > **
>
> I've done a bit more reading. The documentation I have here suggests
> the precharge doesn't erase all of memory.  Precharge copies from the
> sense amplifiers back into the current row. The erasure is a result of
> the sense amplifiers losing their contents faster than the memory
> cells, but even so only one of the 2^12 rows gets erased.

Now that we've established that SDRAM doesn't neccisarily get erased from 
rebooting, does anyone know how long it takes for SDRAM to clear after 
losing power? It seems to me that the fact that the RAM isn't neccisarily 
wiped by the BIOS at boot is less important than wether or not shutting 
down the system and having it shut down for 10 minutes causes the RAM to 
be cleared so that any intruder/thief would be unable to get the 
information neccisary to decrypt the swap...

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSALBu1>; Fri, 11 Jan 2002 20:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbSALBuR>; Fri, 11 Jan 2002 20:50:17 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:11840 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S281214AbSALBuI>; Fri, 11 Jan 2002 20:50:08 -0500
From: brian@worldcontrol.com
Date: Fri, 11 Jan 2002 17:48:30 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CIPE vs. GPLONLY_
Message-ID: <20020112014830.GA6031@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020112010317.GA1765@top.worldcontrol.com> <E16PD12-0000wY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PD12-0000wY-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23.2i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 01:31:24AM +0000, Alan Cox wrote:
> > running CIPE 1.5.2 I get the error above.  Should I be bother the
> > CIPE people with this?  Or is this some kernel thingy that needs
> > to be dealt with?
> 
> Add
> 
> 	MODULE_LICENSE("GPL");
> 
> to the cipe code and all will be well

Thanks. I added that and now I'm just left with sk_run_filter
undef'ed without the GPLONLY_ warning.

I've deleted my kernel sources and am starting everything over
from scratch.  I checked that 'CONFIG_FILTER' was defined
and all seemed in order, but still got the error.

I read through the last few months of the CIPE archives and there
is no mention of such a problem.  Others mention running with
2.4.17, hence my start over.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318898AbSHMBUy>; Mon, 12 Aug 2002 21:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318899AbSHMBUy>; Mon, 12 Aug 2002 21:20:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25847 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318898AbSHMBUx> convert rfc822-to-8bit;
	Mon, 12 Aug 2002 21:20:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: john stultz <johnstul@us.ibm.com>, george anzinger <george@mvista.com>
Subject: Re: [PATCH] tsc-disable_B9
Date: Mon, 12 Aug 2002 18:23:26 -0700
User-Agent: KMail/1.4.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
References: <1028771615.22918.188.camel@cog> <3D540ED3.58F200F6@mvista.com> <1028926681.1118.64.camel@cog>
In-Reply-To: <1028926681.1118.64.camel@cog>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208121823.26918.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 01:58 pm, john stultz wrote:
[ Snip! ]

> (also, doesn't MS have some sort of high res performance counter
> standard they're pushing for in hardware?), ...

Yeah, I think that's called DIG64.  They had a reasonably nice HW timer setup, 
but not so nice for NUMA synchronization as the one we built into the 
[[Deleted by IP Police]] chipset.  That had snapshot and delta adjust logic, 
to synchronize nodes to one interconnect bus clock cycle.  Too bad that 
project was canned....

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com


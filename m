Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318317AbSH0BUA>; Mon, 26 Aug 2002 21:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318318AbSH0BT7>; Mon, 26 Aug 2002 21:19:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:65263 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318317AbSH0BT7> convert rfc822-to-8bit;
	Mon, 26 Aug 2002 21:19:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Date: Mon, 26 Aug 2002 18:23:55 -0700
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
References: <Pine.LNX.4.44.0208241416460.22770-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0208241416460.22770-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208261823.55005.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 August 2002 05:19 am, Zwane Mwaikambo wrote:
> On Tue, 13 Aug 2002, Linus Torvalds wrote:
> > Well, it makes performance _so_ much better on a P4 that it's not even
> > funny. It's basically a "P4 is unusable with SMP" without it.
>
> Out of interest, does anyone have an idea of what Windows does?
>
> 	Zwane

I'm not allowed to report second hand rumors from the folks who assisted with 
the debug of the x440 HAL, so I won't mention that they may or may not be 
using clustered logical interrupts and adjusting priority with the TPR.

I can admit that I have no clue how they assign IRQs to APIC clusters, whether 
randomly or if they try some load balancing scheme.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTAQWE5>; Fri, 17 Jan 2003 17:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbTAQWE5>; Fri, 17 Jan 2003 17:04:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34434 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261529AbTAQWE4>; Fri, 17 Jan 2003 17:04:56 -0500
Subject: Re: [OSDL][BENCHMARK] Database results 2.4 versus 2.5
From: "Timothy D. Witham" <wookie@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030117133718.36df6e42.akpm@digeo.com>
References: <20030117130046.0f73d6d6.akpm@digeo.com>
	 <200301172123.h0HLNBd19275@mail.osdl.org>
	 <20030117133718.36df6e42.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1042841472.1863.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 14:11:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 13:37, Andrew Morton wrote:
> Cliff White <cliffw@osdl.org> wrote:
> >
> > > So it sounds like DBT2 is stabilised now, and producing repeatable results? 
> > > That's excellent.
> > Thanks. the kit's available off Sourceforge now, and we'll have STP version 
> > up Mondayish. 
> 
> OK.  My utter database ignorance was an
> insurmountable-within-two-hour-attention-span problem when I tried to set up
> dbt1.

  That is what we are trying to do with setting it up on STP.  So you
don't have to be a database guy. :-)  I guess what we need to explore
is how to change the setup of dbt{123} on STP so that it gives you 
the information that you need.

Tim

> 
> > > So either the I/O scheduler is doing a better job, or the VM page
> > > replacement decisions are agreeable for this load.
> > 
> > Okay. Is there something we could do that would point at one or the other?
> 
> Different combinations of working set and physical memory will tell us.
> 
> Also, when we have a lot of vmstat/etc traces available we can decide how I/O
> bound it is, and whether we need to look at upping the request queue sizes. 
> Which is something which we can now do, and which could easily make a
> difference here.
> 
> But we'll have to get you onto at least 2.5.58 for that ;)
>
> > would a smaller memory database (say 2GB instead of 4GB ) really show you
> > anything interesting on a 4GB system, since there's so little pressure? 
> 
> Yes, that would be interesting.  We're dealing with single points in
> twenty-seven-dimensional space.  Tweaking input parameter individually helps
> one gain an understanding of what is going on.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311464AbSCVJby>; Fri, 22 Mar 2002 04:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311466AbSCVJbp>; Fri, 22 Mar 2002 04:31:45 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8455 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311464AbSCVJbc> convert rfc822-to-8bit; Fri, 22 Mar 2002 04:31:32 -0500
Date: Fri, 22 Mar 2002 01:30:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3-ac5
In-Reply-To: <Pine.LNX.4.44.0203221110530.2084-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.10.10203220125450.9319-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zwane,

I am trying to close all possible points where the double timer could
happen.  The object is to isolate it to hardware behavior, and determine
what the event sequence is which is committing the sin.

Once constrained, it goes to a lab where I have access to a 320 channel
or 8 x 40 channel POD digital trace/recorder to map the HOST driver
against the device(s) response.  This is a major pain in the debugging
process but it will close the issue for good.

Cheers,


Andre Hedrick
LAD Storage Consulting Group


On Fri, 22 Mar 2002, Zwane Mwaikambo wrote:

> On Fri, 22 Mar 2002, Jörn Engel wrote:
> 
> > "handler not null, ..."
> > if (...handler == NULL) BUG();
> > 
> > I am completely unaware of the real problem, but this doesn't match,
> > does it?
> 
> ooh, Andre just pointed that out.
> 
> Thanks,
> 	Zwane
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


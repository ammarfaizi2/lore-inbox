Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312939AbSD2RPu>; Mon, 29 Apr 2002 13:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312942AbSD2RPt>; Mon, 29 Apr 2002 13:15:49 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:49161 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312939AbSD2RPs>; Mon, 29 Apr 2002 13:15:48 -0400
Date: Mon, 29 Apr 2002 19:15:17 +0200
From: tomas szepe <kala@pinerecords.com>
To: Brian Beattie <alchemy@us.ibm.com>
Cc: Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Thrapp <rthrapp@sbcglobal.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message
Message-ID: <20020429171516.GA25377@louise.pinerecords.com>
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu> <1019926629.2045.698.camel@phantasy> <1020099580.5131.14.camel@w-beattie1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 7 days, 11:59)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Warning: The module you have loaded (%s) does not seem to have an open
> > > 	 source license. Please send any kernel problem reports to the
> > > 	 author of this module, or duplicate them from a boot without
> > > 	 ever loading this module before reporting them to the community
> > > 	 or your Linux vendor
> > 
> > Perfect.  A little long, but otherwise nails it.
> > 
> Warning: The module (%s) does not seem to have a compatible license.
>          Please contact the supplier of this module regarding any
>          problems, or reproduce the problem after rebooting without
>          ever loading this module.
> 
> shorter?

I don't think you can strip the part about open-ness of the code --
it's an essential part of the explanation. And "any problems" might
be too broad.

Moreover, it would make sense - I believe - to include a conditional
like "Should you encounter problems after ...", as the message, as
it stands in this proposal, is rather scary: It seems to tell the
user to *do* expect problems.

T.


-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          

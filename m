Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUHBNRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUHBNRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUHBNPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:15:23 -0400
Received: from mail.lastar.com ([65.89.139.10]:17164 "HELO server11.lastar.com")
	by vger.kernel.org with SMTP id S266523AbUHBNOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:14:55 -0400
Message-ID: <2873B794CB1BE04F80E2968B438680E503C8C991@server6.ctg.com>
From: Jason Gauthier <jgauthier@lastar.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.7 SMP trouble?
Date: Mon, 2 Aug 2004 09:14:47 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay in reponse to this thread.  I've been testing this out,
and it takes awhile.

Well, sadly, I was *wrong*.  After a couple days my 2.4.26 kernel completely
died on me too.
So, I back tracked to 2.4.22, which I had previously thought stable.  But
no, it also died.

So, I started at the beginning.
Here are my results:

2.4.0-2.4.9:  Do not compile.
2.4.10-2.4.15: 'Oops' on boot.
2.4.16-2.4.17: skipped
2.4.18:       Same SMP symptoms.

So, I could try 16/17, but I don't think it matter much at this point.

What should my next step be?

Thanks for all the help so far.

Jason


> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@fsmlabs.com] 
> Sent: Tuesday, July 20, 2004 10:35 AM
> To: Jason Gauthier
> Cc: Linux Kernel
> Subject: RE: 2.6.7 SMP trouble?
> 
> On Tue, 20 Jul 2004, Jason Gauthier wrote:
> 
> > > It would actually help if you found the exact version 
> which stopped 
> > > working, then we can get it looked at and fixed.
> > >
> >
> > If it's in the middle of 2.5 development somewhere that 
> could take me 
> > months
> > :)
> > Assuming 1 day to download compile and start the tests, 
> it's about a 
> > day per kernel.
> 
> Try the following kernels;
> 
> 2.6.0
> 2.5.65
> 2.5.60
> 
> Basically just make large strides, due to the lack of other 
> data this may be the only way.
> 

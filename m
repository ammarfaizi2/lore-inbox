Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315573AbSENJkG>; Tue, 14 May 2002 05:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315575AbSENJkF>; Tue, 14 May 2002 05:40:05 -0400
Received: from laibach.mweb.co.za ([196.2.53.177]:56986 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP
	id <S315573AbSENJkE>; Tue, 14 May 2002 05:40:04 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kosower@hotmail.com (David A. Kosower), linux-kernel@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: System Freeze
Date: Tue, 14 May 2002 09:39:36 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.33
Message-Id: <E177YhM-0006Z9-00@laibach.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem occurs sporadically when netscape (4.78-2) tries to fetch a
> > "complicated" page.  It does not occur reproducibly on any given page.
> > A similar problem occurs so frequently with mozilla
> > (mozilla-2002032709_trunk-0_rh7) as to render the latter unusable.  The
> > system -- a Dell Inspiron 3500 -- is running Redhat 7.2
> > (kernel-2.4.9-31), and is connected to the net via an ethernet
> > PCMCIA talking to an Alcatel 1000 ADSL (which then obviously connects
> > via ADSL).  Presumably this is also a sign of bugs in mozilla, but in
> > any event whatever mozilla is doing should not trigger this.  There are
> > no messages in /var/log/messages.
> 
> The app certain should never be able to trigger such a response.
> 
> > ppp_deflate            39104   0 (autoclean)
> > bsd_comp                4224   0 (autoclean)
> > ppp_async               6848   1 (autoclean)
> > ppp_generic            19336   3 (autoclean) [ppp_deflate bsd_comp
> > ppp_async]
> > slhc                    5056   0 (autoclean) [ppp_generic]
> 
> You also have ppp loaded and a ppp link running ?

I also experienced something similar with the 2.4.19-pre8 kernel + preemptive
when I compile ppp as a module I experience the hard lock, but when compiled
into the kernel that does not
occur.

---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling on the 8th of May?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/



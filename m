Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275172AbRIZNIl>; Wed, 26 Sep 2001 09:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275173AbRIZNIc>; Wed, 26 Sep 2001 09:08:32 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:965 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S275172AbRIZNIR>;
	Wed, 26 Sep 2001 09:08:17 -0400
Message-ID: <079FD72E42C9D311B854009027650E6F024CA70C@xatl02.atl.hp.com>
From: "KRAMER,STEVEN (HP-USA,ex1)" <steven_kramer@hp.com>
To: "'Greg KH'" <greg@kroah.com>, Crispin Cowan <crispin@wirex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: RE: Binary only module overview
Date: Wed, 26 Sep 2001 09:08:40 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> 
> On Tue, Sep 25, 2001 at 04:09:02PM -0700, Crispin Cowan wrote:
> > 
> > Therefore, any additional constraints people may wish to 
> impose, such as 
> > Greg's comment in security.h, are invalid. When someone 
> receives a copy 
> > of the Linux kernel, the license is pure, vanilla GPL, with 
> no funny 
> > riders.*
> 
> My comment in security.h that I proposed [1] does not add any 
> additional
> constraints to the license that is currently on the file.  All it does
> is explicitly state the licensing terms of it, so that there 
> shall be no
> confusion regarding it's inclusion in programs.  If you think this is
> adding an additional restriction to the file, please explain.
> 
> thanks,
> 
> greg k-h

I disagree that your comment does not add any additional constraints.
One could argue that there is enough ambiguity in the GPL and Linus's
explanations regarding uses/derived from, to allow proprietary modules
in the current module framework.  Others can argue the other way. (Refer
back to Crispin's latest email.)  Your additional
comment fixes one of these points of view (call it a refinement rather than
a constraint if you will), so it does go further than the
original license did.  I think the comments we've seen proposed from Crispin
and jmjones (sorry if I attributed the sources incorrectly) are alright, in
that they discuss what is encouraged and discouraged, but do nothing to
refine the original GPL.  If such "style" language is not appropriate
for kernel code, I have no problem in leaving it out either.

You believe your comment does not place any new constraints on the license.
I do believe that it does (because the GPL leaves room for interpretation,
as Crispin has noted).  Would it not be safe, then, to just leave it out
entirely?  You still have the same licensing (that is, no new constraints),
and the few of us that believe otherwise are mollified.

--steve kramer

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWF2MMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWF2MMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbWF2MMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:12:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:7214 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751874AbWF2MML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:12:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OIP3rVaG2b38RgI2zr+Akx8w8evWsYD7TATMmhmFvuY9/8GZCgxHhWe56GyyzL/zx6UnxoCcmVzNHU5fqUQAAwuT1NTfnv4nApWQXjNh5QPv28vzvotsMs64t/X8dhLHsFN4GCpVDwCLzJAMBl/yeNluAnBlmau8ulFj3bLN/bY=
Date: Thu, 29 Jun 2006 14:12:10 +0200
From: Paolo Ornati <ornati@gmail.com>
To: jensmh@gmx.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Message-ID: <20060629141210.0f30a1a6@localhost>
In-Reply-To: <200606291402.21287.jensmh@gmx.de>
References: <20060629134002.1b06257c@localhost>
	<200606291402.21287.jensmh@gmx.de>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 14:02:18 +0200
jensmh@gmx.de wrote:

> > diff --git a/Documentation/block/as-iosched.txt b/Documentation/block/as-iosched.txt
> > index 6f47332..ed24cdd 100644
> > --- a/Documentation/block/as-iosched.txt
> > +++ b/Documentation/block/as-iosched.txt
> > @@ -111,7 +111,7 @@ or if the next request in the queue is "
> >  just completed request, it is dispatched immediately.  Otherwise,
> >  statistics (average think time, average seek distance) on the process
> >  that submitted the just completed request are examined.  If it seems
> > -likely that that process will submit another request soon, and that
> 
> old version is correct, I think.

me too (I've exagerated a bit in killing duplicates ;)

> 
> > +likely that process will submit another request soon, and that
> >  request is likely to be near the just completed request, then the IO
> >  scheduler will stop dispatching more read requests for up time (antic_expire)
> >  milliseconds, hoping that process will submit a new request near the one
> 
> 
> > diff --git a/Documentation/exception.txt b/Documentation/exception.txt
> > index 3cb39ad..75aaa6e 100644
> > --- a/Documentation/exception.txt
> > +++ b/Documentation/exception.txt
> > @@ -10,7 +10,7 @@ int verify_area(int type, const void * a
> >  function (which has since been replaced by access_ok()).
> >  
> >  This function verified that the memory area starting at address 
> > -addr and of size size was accessible for the operation specified 
> 
> maybe old version is correct.

yes

> 
> > +addr and of size was accessible for the operation specified
> >  in type (read or write). To do this, verify_read had to look up the 
> >  virtual memory area (vma) that contained the address addr. In the 
> >  normal case (correctly working program), this test was successful. 
> > diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
> > index f373df1..4a9739a 100644
> > --- a/Documentation/fb/fbcon.txt
> > +++ b/Documentation/fb/fbcon.txt
> > @@ -150,7 +150,7 @@ C. Boot options
> >  
> >  C. Attaching, Detaching and Unloading
> >  
> > -Before going on on how to attach, detach and unload the framebuffer console, an
> 
> not sure here, I'm not a native english speaker.

yes, the old one looks correct

> 
> > +Before going on how to attach, detach and unload the framebuffer console, an
> >  illustration of the dependencies may help.
> >  

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64

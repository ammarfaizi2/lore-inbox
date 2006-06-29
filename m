Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWF2MjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWF2MjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWF2MjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:39:11 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:5031 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1750726AbWF2MjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:39:10 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Paolo Ornati <ornati@gmail.com>
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Date: Thu, 29 Jun 2006 13:39:11 +0100
User-Agent: KMail/1.9.3
Cc: jensmh@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
References: <20060629134002.1b06257c@localhost> <200606291402.21287.jensmh@gmx.de> <20060629141210.0f30a1a6@localhost>
In-Reply-To: <20060629141210.0f30a1a6@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291339.11733.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 June 2006 13:12, Paolo Ornati wrote:
> On Thu, 29 Jun 2006 14:02:18 +0200
>
> jensmh@gmx.de wrote:
> > > diff --git a/Documentation/block/as-iosched.txt
> > > b/Documentation/block/as-iosched.txt index 6f47332..ed24cdd 100644
> > > --- a/Documentation/block/as-iosched.txt
> > > +++ b/Documentation/block/as-iosched.txt
> > > @@ -111,7 +111,7 @@ or if the next request in the queue is "
> > >  just completed request, it is dispatched immediately.  Otherwise,
> > >  statistics (average think time, average seek distance) on the process
> > >  that submitted the just completed request are examined.  If it seems
> > > -likely that that process will submit another request soon, and that
> >
> > old version is correct, I think.
>
> me too (I've exagerated a bit in killing duplicates ;)

"that the process"

> > > +likely that process will submit another request soon, and that
> > >  request is likely to be near the just completed request, then the IO
> > >  scheduler will stop dispatching more read requests for up time
> > > (antic_expire) milliseconds, hoping that process will submit a new
> > > request near the one
> > >
> > >
> > > diff --git a/Documentation/exception.txt b/Documentation/exception.txt
> > > index 3cb39ad..75aaa6e 100644
> > > --- a/Documentation/exception.txt
> > > +++ b/Documentation/exception.txt
> > > @@ -10,7 +10,7 @@ int verify_area(int type, const void * a
> > >  function (which has since been replaced by access_ok()).
> > >
> > >  This function verified that the memory area starting at address
> > > -addr and of size size was accessible for the operation specified
> >
> > maybe old version is correct.
>
> yes

Agreed, but no harm in single quotes around 'addr' and 'size'.

> > > +addr and of size was accessible for the operation specified
> > >  in type (read or write). To do this, verify_read had to look up the
> > >  virtual memory area (vma) that contained the address addr. In the
> > >  normal case (correctly working program), this test was successful.
> > > diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
> > > index f373df1..4a9739a 100644
> > > --- a/Documentation/fb/fbcon.txt
> > > +++ b/Documentation/fb/fbcon.txt
> > > @@ -150,7 +150,7 @@ C. Boot options
> > >
> > >  C. Attaching, Detaching and Unloading
> > >
> > > -Before going on on how to attach, detach and unload the framebuffer
> > > console, an
> >
> > not sure here, I'm not a native english speaker.
>
> yes, the old one looks correct

I disagree. The cleanup's either an improvement, or the sentence should be 
rewritten, "Before continuing with how to attach, detect and unload the 
framebuffer.."

I think if you're going to improve the quality of documentation, there's no 
harm to make minor grammatical improvements. Duplicate words are almost 
always a bad thing, and they really disrupt reading flow.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

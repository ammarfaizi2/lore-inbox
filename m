Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTJBIsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 04:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTJBIsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 04:48:51 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:26381 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263286AbTJBIss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 04:48:48 -0400
Message-ID: <3F7BE886.8070401@aitel.hist.no>
Date: Thu, 02 Oct 2003 10:57:42 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: kartikey bhatt <kartik_me@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
References: <Law11-F67ATnLE7P95L00001388@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kartikey bhatt wrote:
> hey everyone who have joined this thread, my fundamental question have got
> out of scope. I mean to say
> 
> 1. Kernel level support for graphics device drivers.
> 2. On top of that, one can develop complete lightweight GUI.
> 3. Maybe kernel can provide support for event handling.
> 
> and I still stick to my opinion that graphics card is a computer resource
> that needs to be managed by OS   rather than 3rd party developers.

The card is managed by the os - X has to ask the kernel nicely to get it.
(Try starting another X server inside an xterm and see how
that is refused.)

The details of drawing the windows is something the os don't
need to worry about though - that is the job of X.

Please explain whats wrong about "3rd party developers".  Depending on
how you look at it, all of linux is "3rd part developers" except from Linus.

> Just feeding in patches to provide support for AGP gart and DRI
> is an adhoc solution, a stark immoral choice.

Explain the immoral part. Committing a crime is (usually) immoral.
Designing software in a way you dislike isn't.

> you don't know my frustration when i got PC and wasn't able to
> run X until i810 agp gart support was available at kernel level.
> 
So?

Having graphichs in the kernel would *not* change this at all.
You would still have to wait for graphichs support for your card.
The kernel would still have to support i810 agp gart.

Linux doesn't support every graphics solution in existence.  That is
a fact of life.  Wheter the missing part is in kernel or somewhere
else doesn't matter at all.  It either works or it don't.

> And if you feel that I am a guy heavily dependent on X that's not true.


> I just mean to say if anything is that kernel level support for graphics 
> device drivers.
This sentence didn't make sense to me.  Syntax error? :-)


> And X will be automatically eliminated.
Sure.  Having the kernel provide graphichs would eliminate X, if the
kernel would support all the stuff X supports.  But whats the
_point_ of eliminating X?

1. It wouldn't be faster
2. You wouldn't get support for more cards this way
3. It wouldn't be better in other ways either

Using X for graphichs is nice however, for several reasons:

1. Separation of kernel and graphichs system.  This means
    we can trivially run without graphichs if we don't need it.
    And yes - there are many such uses for linux.  The desktop
    is merely one of many places where you find linux.
2. There would be fewer graphichs developers for linux with
    the graphichs in-kernel.  Today X is used not only by linux people,
    it is also used by other unices like bsd, and others too.
    A bsd/os2/... X developer working on X today will benefit linux
    too.  That won't happen with a graphichs system internal to linux.


Helge Hafting




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282360AbRKXEAL>; Fri, 23 Nov 2001 23:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282361AbRKXEAB>; Fri, 23 Nov 2001 23:00:01 -0500
Received: from air-1.osdl.org ([65.201.151.5]:54280 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S282360AbRKXD7x>;
	Fri, 23 Nov 2001 22:59:53 -0500
Message-ID: <3BFF1AAB.273A2BB@osdl.org>
Date: Fri, 23 Nov 2001 19:57:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: admin@nextframe.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove last references to linux/malloc.h
In-Reply-To: <20011122145527.A117@sexything> <27400.1006437269@redhat.com> <20011122150738.D117@sexything>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten Helgesen wrote:
> 
> Hey David.
> 
> I see your point - but someone has obiously decided to switch from malloc.h to slab.h, and I do not
> see the point in having three references to malloc.h when malloc.h only prints a warning and then includes
> slab.h
> 
> == Morten
> 
> On Thu, Nov 22, 2001 at 01:54:29PM +0000, David Woodhouse wrote:
> >
> >
> > admin@nextframe.net said:
> > >  Ok people - stop submitting patches which include malloc.h. Include
> > > slab.h instead. :)
> >
> > Bah. I was sort of hoping we'd come to our collective senses and switch
> > them all back.
> >
> > What does malloc.h do? Stuff to do with memory allocation, one presumes.
> > What does slab.h do? Some random implementation detail that people have no
> > business knowing about.

Too bad someone decided to change.  I agree with David.

malloc.h is just too plain obvious, I suppose.
slab.h is only an implementation detail.

~Randy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136833AbREITGk>; Wed, 9 May 2001 15:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136828AbREITGU>; Wed, 9 May 2001 15:06:20 -0400
Received: from ns-inetext.inet.com ([199.171.211.140]:38327 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S136830AbREITGR>; Wed, 9 May 2001 15:06:17 -0400
Message-ID: <3AF99522.C3DC59B@inet.com>
Date: Wed, 09 May 2001 14:06:10 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: standard queue implementation?
In-Reply-To: <3AF96062.19528A86@inet.com> <3AF98697.44437FEB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Eli Carter wrote:
> >
> > All,
> >
> > I did a quick look in include/linux for a standard implementation of an
> > array-based circular queue, but I didn't see one.
> >
> > I was thinking something that could be declared, allocated, and then
> > used with an addq and a removeq.  A deallocator would also be good.
> >
> > Is there such a beast in the kernel?  If not, it seems that having
> > something like this would reduce the potential for bugs.
> >
> > Thoughts?
> >
> Are you possibly looking for include/linux/list.h ?
> 
> Routines to build and manager doubly linked circular lists.

I've seen that, but no.  I want a queue of pointers, and the queue
can/should be of fixed length.  (I don't want to deal with
allocating/deallocating nodes for this... I just need something simple.)

For now, I'll just write my own, but I may try submitting it as a
"kernel library" type thing later on.

Thanks,

Eli
-----------------------.   No wonder we didn't get this right first time
Eli Carter             |      through. It's not really all that horribly 
eli.carter(at)inet.com `- complicated, but the _details_ kill you. Linus

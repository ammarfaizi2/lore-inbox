Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270494AbRHHOfp>; Wed, 8 Aug 2001 10:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270498AbRHHOff>; Wed, 8 Aug 2001 10:35:35 -0400
Received: from palrel2.hp.com ([156.153.255.234]:16614 "HELO palrel2.hp.com")
	by vger.kernel.org with SMTP id <S270494AbRHHOfR>;
	Wed, 8 Aug 2001 10:35:17 -0400
Message-ID: <3B714824.5B78CE40@india.hp.com>
Date: Wed, 08 Aug 2001 19:39:41 +0530
From: Milind <dmilind@india.hp.com>
Organization: HP
X-Mailer: Mozilla 4.7 [en] (X11; I; HP-UX B.10.20 9000/712)
X-Accept-Language: en
MIME-Version: 1.0
To: mark@winksmith.com
Cc: linux-kernel@vger.kernel.org, blore-linux@yahoogroups.com
Subject: Info about top command required
In-Reply-To: <001f01c11fca$3bfd5ec0$94604c0f@india.hp.com> <3B70D2A6.F0C0ACC4@india.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milind wrote:

> Hi mark ,
>
> Thanks for the info.
>
> But the question really is , whether SIZE corrosponds to
>
>   real memory( real text + real data + real stack)
>                               OR
>   virtual  memory(virtual text + virtual data + virtual stack)
>                               OR
>    both????
>
> Thanks
> Milind
>
> > -----Original Message-----
> > From: mark@winksmith.com [mailto:mark@winksmith.com]
> > Sent: Tuesday, August 07, 2001 6:13 PM
> > To: Ananth P
> > Cc: TUXMA (E-mail)
> > Subject: Re: [ma-linux] Info about top command required
> >
> > On Tue, Aug 07, 2001 at 12:55:28PM +0530, Ananth P wrote:
> > >  I wanted to know how the 'SIZE' field in the output of 'top' command is
> > > calculated in linux.
> >
> > well, if i remember correctly the size field in ps results in process
> > size in clicks.  one click is 4096 bytes.  it's pretty good for relative
> > measurement (e.g. this one is 50 clicks, the other one is 5000 clicks).
> >
> > let's see about 'top'.  reading man page
> >
> >         SIZE    The size of the task's code plus data plus stack
> >                 space, in kilobytes, is shown here.
> >
> > so, it sounds like kb.  in addition, you might find these fields helpful
> > too (from the man page).
> >
> >         TSIZE   The code size of the task. This gives strange
> >                 values for kernel processes  and is broken
> >                 for ELF processes.
> >
> >         DSIZE   Data + Stack size. This is broken for ELF
> >                 processes.
> >
> > --
> > Mark Smith
> > mark@winksmith.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317375AbSGDIgO>; Thu, 4 Jul 2002 04:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317376AbSGDIgN>; Thu, 4 Jul 2002 04:36:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:15001 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317375AbSGDIgL>;
	Thu, 4 Jul 2002 04:36:11 -0400
Message-Id: <5.1.0.14.2.20020704101940.00b25808@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 04 Jul 2002 10:36:23 +0200
To: root@chaos.analogic.com, "Stephen C. Tweedie" <sct@redhat.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [OKS] Module removal
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.c
 om>
References: <20020702123718.A4711@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:04 AM 7/2/2002 -0400, Richard B. Johnson wrote:
>On Tue, 2 Jul 2002, Stephen C. Tweedie wrote:
>
> > Hi,
> >
> > > The suggestion was made that kernel module removal be depreciated or
> > > removed. I'd like to note that there are two common uses for this
> > > capability, and the problems addressed by module removal should be 
> kept in
> > > mind. These are in addition to the PCMCIA issue raised.
> >
> > > 1 - conversion between IDE-CD and IDE-SCSI. Some applications just work
> > > better (or usefully at all) with one or the other driver used to read 
> CDs.
> >
> > The proposal was to deprecate module removal, *not* to deprecate
> > dynamic registration of devices.  If you want to maintain the above
> > functionality, then there's no reason why a device can't be
> > deregistered from one driver and reregistered on another while both
> > drivers are present.  Note that the scsi stack already allows you to
> > dynamically register and deregister specific targets on the fly.
>
>As I am led to understand from reading this thread, there is some
>known bug caused by module removal. Therefore the "solution" is to
>remove module removal capability.

Read the thread more carefully, and you'll understand more than "some
known bug".  Heck, you may even be able to contribute to a more
palatable race solution than depreciating module unload entirely.

>This is absurd. Next, somebody will remove network capability because
>there's some bug in it.  Hello there........?  Are there any carbon-
>based life-forms out there?

I'm not absolutely certain that those life-forms discussing options are
carbon-based ;-) but they have demonstrated considerable knowledge
of the subject IMO.

         -Mike


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSGBMAQ>; Tue, 2 Jul 2002 08:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSGBMAP>; Tue, 2 Jul 2002 08:00:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14466 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316746AbSGBMAO>; Tue, 2 Jul 2002 08:00:14 -0400
Date: Tue, 2 Jul 2002 08:04:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
In-Reply-To: <20020702123718.A4711@redhat.com>
Message-ID: <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, Stephen C. Tweedie wrote:

> Hi,
> 
> > The suggestion was made that kernel module removal be depreciated or
> > removed. I'd like to note that there are two common uses for this
> > capability, and the problems addressed by module removal should be kept in
> > mind. These are in addition to the PCMCIA issue raised.
>  
> > 1 - conversion between IDE-CD and IDE-SCSI. Some applications just work
> > better (or usefully at all) with one or the other driver used to read CDs.
> 
> The proposal was to deprecate module removal, *not* to deprecate
> dynamic registration of devices.  If you want to maintain the above
> functionality, then there's no reason why a device can't be
> deregistered from one driver and reregistered on another while both
> drivers are present.  Note that the scsi stack already allows you to
> dynamically register and deregister specific targets on the fly.

As I am led to understand from reading this thread, there is some
known bug caused by module removal. Therefore the "solution" is to
remove module removal capability.

This is absurd. Next, somebody will remove network capability because
there's some bug in it.  Hello there........?  Are there any carbon-
based life-forms out there?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


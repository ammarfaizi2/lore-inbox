Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSDSXBJ>; Fri, 19 Apr 2002 19:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313162AbSDSXBH>; Fri, 19 Apr 2002 19:01:07 -0400
Received: from pc132.utati.net ([216.143.22.132]:30362 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313122AbSDSWn3>; Fri, 19 Apr 2002 18:43:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Christian Schoenebeck <christian.schoenebeck@epost.de>,
        brian@worldcontrol.com
Subject: Re: power off (again)
Date: Fri, 19 Apr 2002 12:07:37 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <20020419045648.GA2104@top.worldcontrol.com> <20020419122807.319D647B1@debian.heim.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020419230335.7B868757@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 April 2002 08:56 am, Christian Schoenebeck wrote:
> Am Freitag, 19. April 2002 06:56 schrieb brian@worldcontrol.com:
> > On Thu, Apr 18, 2002 at 10:40:06PM +0200, Christian Schoenebeck wrote:
> > > I'm still fighting the problem that power off doesn't work with one of
> > > our machines since moving from 2.2.19 to 2.4.7 kernel.
> >
> > I have no idea if this will help but most of my systems have
> >
> > append="apm=power-off"
> >
> > in their lilo config.
>
> And ours append="apm=on", but I also tried apm=power-off - didn't help

Oh, forgot to mention earlier...

The machines that refuse to actually switch off all SUSPEND just fine.  
They'll power down most of the way and stay suspended on battery power for a 
week.

It's just that when you tell them to actually switch off, use NO battery, and 
reboot when you come back up...  Then they won't even suspend, they just stay 
on but spin the hard drive down.

Weird, eh?

Rob


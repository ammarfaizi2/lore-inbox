Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313163AbSDTToO>; Sat, 20 Apr 2002 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSDTToO>; Sat, 20 Apr 2002 15:44:14 -0400
Received: from pc132.utati.net ([216.143.22.132]:46234 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313163AbSDTToL>; Sat, 20 Apr 2002 15:44:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Thunder from the hill <thunder@ngforever.de>,
        "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: power off (again)
Date: Sat, 20 Apr 2002 09:45:38 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Christian Schoenebeck <christian.schoenebeck@epost.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <1019163766.6743.8.camel@aurora> <3CC17A1D.20901@ngforever.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020420200430.337D1730@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 10:24 am, Thunder from the hill wrote:
> Hi,
>
> Trever L. Adams wrote:
> > I can't remember where you make this change on RedHat
>
> Should be /etc/rc.d/init.d/halt. See appended patch.
>
> Regards,
> Thunder

Unless your patch is reversed, that's what I've got (on the red hat systems, 
the linux from scratch systems use BSD style init scripts because I'm not 
THAT masochistic).  It doesn't help.

I've also wandered through arch/i386/kernel/apm.c enough to confirm that 
apm_power_off() does seem to be getting called.  And the hard drive does 
audibly spin down on the systems that have the case off, it just doesn't stop 
throwing out a video signal to the monitor, using the processor to heat the 
room, etc...

I might get some time to thump onn it more this weekend, but it's pretty far 
down on the to-do list...

Rob

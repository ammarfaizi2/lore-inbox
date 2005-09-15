Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVIOJsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVIOJsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVIOJsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:48:47 -0400
Received: from web51003.mail.yahoo.com ([206.190.38.134]:13473 "HELO
	web51003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932420AbVIOJsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:48:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fOedy6JCBDsCU4VGWNFzP1UD+5qLk3Ow9Vg6cwuRWq3uhoZGIzaK7XAPGh9kW4JhDFV0cfKIOkvR6w+bPmzEpc2jZiG0kI4SRTBsi76QtmQjLDFOLXNbYmeM+rdUaJyuBnYeRRfjghhgREJi/Kp/M2ijxZmPMYx4QIlIQHh7Nh8=  ;
Message-ID: <20050915094842.31636.qmail@web51003.mail.yahoo.com>
Date: Thu, 15 Sep 2005 02:48:42 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
To: marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <200509151733.16569.marekw1977@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Marek W <marekw1977@yahoo.com.au> wrote:

> On Thu, 15 Sep 2005 16:18, Valdis.Kletnieks@vt.edu
> wrote:
> 
> Wasn't I being optimistic :) but hey, it's good to
> see that many modules.
> 
> > > I'd prefer for something to select the modules
> necessary for my hardware.
> > > I can't afford the time to keep up to date with
> that's new and what
> > > isn't, what has changed, what has been
> superseded, which module works
> > > with which device, chipset even, etc...
> >
> > I'm of the opinion that if you don't have that
> much time, you should be
> > using a distro kernel where somebody *else* is
> taking the time.  If you're
> > the type that builds their own kernel, the *last*
> thing you want is a tool
> > glossing over the fact that a module has been
> superceded.  Who's going to
> > take care of the matching changes for
> /etc/modprobe.conf and similar
> > userspace changes, and other stuff like that? (I
> figure if 'make oldconfig'
> > asks a question, I should take notice, and any
> userspace changes that don't
> > get made are my fault - and if 'make oldconfig'
> switches drivers on me
> > without asking, that's a *bug* that lkml will hear
> about.. ;)
> 
> This is exactly why I switched to Gentoo and use
> gentoo-sources kernel.
>
As far as I know uses Gentoo the configuration that
will be on the live-Cd. So 
1. they might be alot of not needed modules 
2. Some Hardware might be undetected.

> However, keep in mind that when I do 'make
> oldconfig', more often then now the 
> help on new options is insufficient to make a
> decision on whether or not 
> something should be included.
> 
> Secondly, I'd love to know exactly what sort of
> hardware is inside my laptop, 
> but funnily enough I find out the chipsets and
> vendors by running lspci.

The good thing about lspci (comparing to the others
Hardware detection like kudzu or discovery) it not
only uses the /proc files for getting the Hardware
information it also grabs its information directly
from the I/O of the Hardwares. But it lacks of getting
alls the Hardwares e.g. CD-Rom, floppy... 
It would be great if there is a Programm that gets all
the Hardware information directyl from the I/O
independent from the Kernel-installation.    


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

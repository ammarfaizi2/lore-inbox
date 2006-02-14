Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWBNWNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWBNWNs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWBNWNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:13:48 -0500
Received: from smtp.enter.net ([216.193.128.24]:63493 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1422817AbWBNWNr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:13:47 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 17:22:50 -0500
User-Agent: KMail/1.8.1
Cc: Valdis.Kletnieks@vt.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <200602140721.25066.dhazelton@enter.net> <43F20873.nailMWZM17DCF@burner>
In-Reply-To: <43F20873.nailMWZM17DCF@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602141722.51572.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 11:42, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > > How about pointing to _useful_ documentation:
> > >
> > > -	How to find _any_ device that talks SCSI?
> > >
> > > -	How does HAL allow one cdrecord instance to work
> > > 	without being interrupted by HAL?
> > >
> > > -	How to send non disturbing SCSI commands from another
> > > 	cdrecord process in case one or more are already running?
> > >
> > > Jörg
> >
> > Documentation?
> >
> > Didn't even take me two minutes to find the entire specification for hald
> > on the net.
> >
> > http://cvs.freedesktop.org/*checkout*/hal/hal/doc/spec/hal-spec.html?only
> >_with_tag=HEAD
>
> ????
> Did yoiu try to read this?

Did you notice my comment? When I sent that message I'd been awake for nearly 
24 hours helping a friend through depression and was ready to fall asleep 
while checking my email. I have since read it and I understand your problem. 
That documentation does state, however, that the HAL system is normally 
accessed via the dbus system message bus. In order to help you with that 
facet of things here is a link to the dbus documentation: 
http://dbus.freedesktop.org/doc/dbus-specification.html

And I will look into the HAL source code and provided headers to see if I 
cannot find you a direct interface such as dbus has with HAL. But not at the 
current moment, as I am limited in my available time.

> I like to see a whitepaper first that allows me to get an overview in less
> than 10 minutes. If this is not available, I suspect you just try another
> attempt to waste my time.

Huh? I understood HAL in less than ten minutes from that specification. But 
then, any competant programmer would spend a great deal more time on learning 
an interface. I have been studying the ATAPI, SCSI and MMC specs for more 
than six months now and, while I have a firm grasp of the concepts, could not 
sit down and write a piece of software that spoke those protocols. (This is 
mainly because I haven't been focusing on them, but rather referencing in 
passing after having read them in their entirety at least once)

DRH

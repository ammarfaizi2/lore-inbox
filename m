Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285829AbSBGIAx>; Thu, 7 Feb 2002 03:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSBGIAo>; Thu, 7 Feb 2002 03:00:44 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61714 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S285829AbSBGIAg>; Thu, 7 Feb 2002 03:00:36 -0500
Message-Id: <200202070758.g177wlt05475@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] List of maintainers
Date: Thu, 7 Feb 2002 09:58:49 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202051015.g15AFDt19761@Port.imtp.ilyichevsk.odessa.ua> <200202051357.g15DvDt22229@Port.imtp.ilyichevsk.odessa.ua> <20020205180037.GC1052@kroah.com>
In-Reply-To: <20020205180037.GC1052@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 February 2002 16:00, Greg KH wrote:
> > > Vojtech Pavlik <vojtech@ucw.cz> [5 feb 2002]
> > > 	Input device drivers (drivers/input/*, drivers/char/joystick/*).
> > > 	Some USB drivers (printer, acm, catc, hid*, usbmouse, usbkbd, wacom).
> > > 	VIA IDE support.
> >
> > I want these entries to sound like "Hey, I am working on these parts of
> > the kernel, if you have something, send it to me not to Linus". With
> > precise indication of those parts and your level of involvement:
>
> Um, isn't that what Vojtech said?  You just converted his response into
> full sentances.

I am happy with his entry. "I want these entries...." was targeted mostly at
other entry makers.

> But I'm curious why you want to sort the list of maintainers by the
> maintainer name.  Isn't the format of the current MAINTAINERS file much
> nicer in that it's sorted by subsystem and driver type?  For if you want
> to know who to send your USB Printer driver changes to, you just look
> that up, instead of having to search through your file, which is ordered
> in the other way.

Hmm. Don't know how to do it best... reverse date sort clearly shows obsolete 
entries, I like it. Also people might like to see who is in the upper part of 
the list (i.e. who is active), I like it too.

> So in short, why are you trying to do this?

To improve lk development process. To help bug reports and patches reach
_relevant_ addresses. This is big problem now, big guys may ignore small 
fixes, fixes posted to lkml are likely to never even _reach_ big guys who 
don't read lkml (guess who :-). This confuse newcomers and J. Random Hackers.

I hope patchbot and dynamically updated maintainer list may help lk 
development scale better.
--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTIZUOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbTIZUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:14:24 -0400
Received: from tench.street-vision.com ([212.18.235.100]:8874 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S261620AbTIZUOW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:14:22 -0400
Subject: Re: khubd is a Succubus!
From: Justin Cormack <justin@street-vision.com>
To: bugsy@isl.is
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200309261855.43487.bugsy@isl.is>
References: <200309261724.56616.bugsy@isl.is>
	<200309261843.10099.bugsy@isl.is> <20030926183522.GB17690@kroah.com> 
	<200309261855.43487.bugsy@isl.is>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 26 Sep 2003 21:14:08 +0100
Message-Id: <1064607248.8723.53.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-26 at 19:55, Börkur Ingi Jónsson wrote:
> On Friday 26 September 2003 18:35, you wrote:
> > On Fri, Sep 26, 2003 at 06:43:10PM +0000, Börkur Ingi Jónsson wrote:
> > > nvidia: no version magic, tainting kernel.
> > > nvidia: module license 'NVIDIA' taints kernel.
> > > 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed
> > > Jul 16 19:03:09 PDT 2003
> > > 0: NVRM: AGPGART: unable to retrieve symbol table
> >
> > Does this same problem happen without the nvidia driver loaded?
> 
> 
> >
> > > > > 2. I have a usb keyboard plugged in It's packard Bell model number
> > > > > 9201
> > > > >
> > > > > 3. This did not happen with 2.4
> > > > >
> > > > > 4. ACPI is for laptops correct? I'm using a desktop and I've never
> > > > > installed anything ACPI related..
> > > >
> > > > But is ACPI configured in your kernel?
> > >
> > > I checked the config and ACPI was configured.. Now compiling without
> > > ACPI. Is that the reason? I think it was selected by default.
> >
> > I do not know, but if you do not need it, it should not be selected.
> >
> >
> > greg k-h
> 
> how do I unload the nvidia driver?

boot up without starting X. Add 3 to your kernel command line or change
default runlevel in /etc/inittab to 3 not 5 (you can change it back
later). removing it wont help, you need a clean start without it loaded.



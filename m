Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319119AbSHGSoM>; Wed, 7 Aug 2002 14:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSHGSoM>; Wed, 7 Aug 2002 14:44:12 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58525 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S319119AbSHGSoL>; Wed, 7 Aug 2002 14:44:11 -0400
Date: Wed, 7 Aug 2002 20:47:40 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopses on dual Athlon with 2.4.19-ac4 and 2.4.20-pre1-ac1
Message-ID: <20020807184740.GJ23816@os.inf.tu-dresden.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <20020807162932.GH23816@os.inf.tu-dresden.de> <1028746623.18156.328.camel@irongate.swansea.linux.org.uk> <20020807180503.GI23816@os.inf.tu-dresden.de> <1028748942.18478.330.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1028748942.18478.330.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 07, 2002 at 20:35:42 +0100, Alan Cox wrote:
> On Wed, 2002-08-07 at 19:05, Adam Lackorzynski wrote:
> > On Wed Aug 07, 2002 at 19:57:03 +0100, Alan Cox wrote:
> > > On Wed, 2002-08-07 at 17:29, Adam Lackorzynski wrote:
> > > > I have a dual Athlon here which ooopses after 2 minutes of dnetc when
> > > > running 2.4.19-ac4 or 2.4.20-pre1-ac1. I cannot reproduce this with
> > > > 2.4.19 or 2.4.20-pre1. The two Athlons are sitting on a A7M266-D.
> > > 
> > > Are you loading the amd76x_pm module for power management ?
> > 
> > No, the module wasn't loaded in any of the cases. Only ipv6 and rtc are
> > loaded.
> 
> Can you reproduce it with ACPI disabled ?

Yes, 2.4.20-pre1-ac1 with acpi=off crashed after 5 mins of uptime.
Unfortunately I only had remote access right now (and forgot to plug the
serial cable in another box), so that Oops has to wait... :/



Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317409AbSGOKDw>; Mon, 15 Jul 2002 06:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317410AbSGOKDv>; Mon, 15 Jul 2002 06:03:51 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:51630 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S317409AbSGOKDu>;
	Mon, 15 Jul 2002 06:03:50 -0400
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Ed Sweetman <safemode@speakeasy.net>, arndb@de.ibm.com
Subject: Re: kbd not functioning in 2.5.25-dj2
References: <1026545050.1203.116.camel@psuedomode>
	<20020713073717.GA9203@wizard.com>
	<1026547292.1224.132.camel@psuedomode>
	<1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz>
	<m3y9cde9gx.fsf@lapper.ihatent.com>
	<200207150856.g6F8ujs99442@d06relay02.portsmouth.uk.ibm.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 15 Jul 2002 12:06:31 +0200
In-Reply-To: <200207150856.g6F8ujs99442@d06relay02.portsmouth.uk.ibm.com>
Message-ID: <m3r8i5i9ug.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@bergmann-dalldorf.de> writes:

> Alexander Hoogerhuis wrote:
> 
> > I mentioned this before, but I had major pains with the new input
> > drivers for keyboards not working with the Comapq Armada M700's, and
> > gave that up. Now I got a new Compaq N800c, which forced me onto 2.5.x
> > because of some of the hardware (Intel ICH3 et al).
> As I reported earlier (but appearantly unnoticed), on my Thinkpad A30p
> (which uses the ICH3), keyboard and mouse don't work with the new input
> layer when CONFIG_X86_UP_IOAPIC is on, but I have no problems (except
> my USB mouse) when I switch that off.
> 
> > I only have two problems left is that I have a laptop with both a
> > stick and a glidepad, and the psmouse driver only enables the pad, and
> > not the stick. The other is that the rpm command segfaults for no
> > apparent reason under 2.5.x (tried .23, 24., and .25 and -dj varieties
> > of them). Same also happens with vim, second time it edits a file.
> 
> For me, the usb mouse stopped working with 2.5.25 in all configurations I
> tried, the stick works without UP_IOAPIC. Unless the new input driver
> is supposed to be a complete drop-in replacement for the old one, I still
> assume that is a configuration error on my side.
> 

I have it configured in, but it claims it dont have one at boot time
(and I honestly dont know if the the hardware is physically in the
box):

No local APIC present or hardware disabled

> >> On Sat, Jul 13, 2002 at 04:45:56AM -0400, Ed Sweetman wrote:
> >> > CONFIG_X86_UP_IOAPIC=y
> 
> Yup, Ed has this one on as well. Alexander, what about your systems?
> 

CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

>         Arnd <><
> 

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

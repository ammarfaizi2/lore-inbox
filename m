Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSGOIyC>; Mon, 15 Jul 2002 04:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSGOIyB>; Mon, 15 Jul 2002 04:54:01 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:4545 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S317392AbSGOIyB>; Mon, 15 Jul 2002 04:54:01 -0400
Message-Id: <200207150856.g6F8ujs99442@d06relay02.portsmouth.uk.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: kbd not functioning in 2.5.25-dj2
To: Alexander Hoogerhuis <alexh@ihatent.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, Ed Sweetman <safemode@speakeasy.net>
Mail-Copies-To: arndb@de.ibm.com
Date: Mon, 15 Jul 2002 12:56:43 +0200
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713110619.A28835@ucw.cz> <m3y9cde9gx.fsf@lapper.ihatent.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis wrote:

> I mentioned this before, but I had major pains with the new input
> drivers for keyboards not working with the Comapq Armada M700's, and
> gave that up. Now I got a new Compaq N800c, which forced me onto 2.5.x
> because of some of the hardware (Intel ICH3 et al).
As I reported earlier (but appearantly unnoticed), on my Thinkpad A30p
(which uses the ICH3), keyboard and mouse don't work with the new input
layer when CONFIG_X86_UP_IOAPIC is on, but I have no problems (except
my USB mouse) when I switch that off.

> I only have two problems left is that I have a laptop with both a
> stick and a glidepad, and the psmouse driver only enables the pad, and
> not the stick. The other is that the rpm command segfaults for no
> apparent reason under 2.5.x (tried .23, 24., and .25 and -dj varieties
> of them). Same also happens with vim, second time it edits a file.

For me, the usb mouse stopped working with 2.5.25 in all configurations I
tried, the stick works without UP_IOAPIC. Unless the new input driver
is supposed to be a complete drop-in replacement for the old one, I still
assume that is a configuration error on my side.

>> On Sat, Jul 13, 2002 at 04:45:56AM -0400, Ed Sweetman wrote:
>> > CONFIG_X86_UP_IOAPIC=y

Yup, Ed has this one on as well. Alexander, what about your systems?

        Arnd <><

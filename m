Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSGOOIH>; Mon, 15 Jul 2002 10:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317495AbSGOOIG>; Mon, 15 Jul 2002 10:08:06 -0400
Received: from speech.linux-speakup.org ([129.100.109.30]:59830 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S317463AbSGOOIE>; Mon, 15 Jul 2002 10:08:04 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
References: <E17T2P5-0003DF-00@the-village.bc.nu>
	<x7hej5djbj.fsf@speech.braille.uwo.ca>
	<m1adotpats.fsf@frodo.biederman.org>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 15 Jul 2002 10:10:53 -0400
In-Reply-To: <m1adotpats.fsf@frodo.biederman.org>
Message-ID: <x7n0sthyj6.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> The current architecture does allows for all BIOS parameters to be set
> from Linux so there is an accessibility gain there.
> 
> Given the space constraints on the BIOS side, either a very small
> standalone speach synthsizer needs to be constructed, or more likely
> a set of tones (that can work like post codes) can be introduced
> to give a feel where in the boot process the BIOS is.

A small synthesizer is one of the things I am trying to work on.
After reading all the wonderful suggestions I've seen here on this
thread I'm not sure just how I'll fit it all together.  Key tones to
indicate when particular events have taken place with the pc's speaker
could be very useful.  We use the bell character to indicate the lilo
boot prompt currently.  It could be expanded to indicate a lot of
useful events if built-in to the BIOS.

A user space program to give access to the cmos bios settings is
another feature which would be very useful.  Currently there is no way
for a blind person to set up his/her own bios under the other O.S but
it could conceivably be done under Linux.

A few folks have written me suggesting the possibility of using the pc
speaker as the output for a low quality speech synth.  I am skeptical
about the feasability of this but it would give everyone blind or
otherwise useful feedback possibly on systems which are headless.  I
am not exactly sure yet just how small I can get a useable speech
synth.  That is the whole reason for this thread in the first place.

> 
> After that a nice bootloader based on the Linux kernel with a real
> user space can be loaded from the hard drive where there is plenty of
> room.  Everything that possibly could would need to be built as
> modules to decrease the time to user space, and to allow as many
> messages to be processed by the speech synthesizer.

Is there an organized linuxbios project?  If so, could someone give me
a pointer please.

  Kirk
-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061

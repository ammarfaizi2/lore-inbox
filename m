Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288867AbSAXSpm>; Thu, 24 Jan 2002 13:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288891AbSAXSpb>; Thu, 24 Jan 2002 13:45:31 -0500
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:56574 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288867AbSAXSpT>; Thu, 24 Jan 2002 13:45:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Marko Rauhamaa <marko@pacujo.nu>, linux-kernel@vger.kernel.org
Subject: Re: IRQ routing conflict
Date: Thu, 24 Jan 2002 05:43:04 -0500
X-Mailer: KMail [version 1.3.1]
Cc: miles@megapathdsl.net.marko
In-Reply-To: <m3hepd1ggp.fsf@lumo.pacujo.nu>
In-Reply-To: <m3hepd1ggp.fsf@lumo.pacujo.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020124184518.WSKJ21740.femail36.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 January 2002 05:58 am, Marko Rauhamaa wrote:

> My new laptop is mostly working, but I can't get my sound card to
> produce a sound. I'm suspecting that the sound driver is not receiving
> interrupts. I can hear the clicking when the driver is loaded -- and I
> have used aumix to set the volume. Both ALSA and OSS (commercial) fail
> the same way.

I've got a Dell Inspiron 3500 where the sound works fine on the first boot 
but the IRQ gets lost after an APM suspend, and even unloading/reloading the 
module doesn't help.  (The I/O addresses are still valid, but it gets no IRQ. 
 KDE has no sound, from the command line it loops playing the same segment 
over and over complaining about timeouts...)

It's been doing this for a year.  I've mentioned it here a few times before.  
I've played around with setpci and such, but haven't been able to fix it.  I 
just reboot when I want sound.  The bios sets it up right (on a cold boot, 
not returning from APM).  Linux (even 2.4.17) does not.

Rob

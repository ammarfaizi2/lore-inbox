Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTD3Iub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTD3Iua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:50:30 -0400
Received: from codepoet.org ([166.70.99.138]:25567 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S261962AbTD3Iu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:50:26 -0400
Date: Wed, 30 Apr 2003 03:02:42 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
Message-ID: <20030430090242.GA15480@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030424212508.GI14661@codepoet.org> <200304251401.36430.m.c.p@wolk-project.de> <200304251410.31701.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304251410.31701.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Apr 25, 2003 at 02:10:31PM +0200, Marc-Christian Petersen wrote:
> On Friday 25 April 2003 14:01, Marc-Christian Petersen wrote:
> 
> Hi again,
> 
> > > I was crazy enough to take ALSA 0.9.2 and made it into a patch vs
> > > 2.4.x a week or two ago.  I just prefer to have ALSA be part of
> > > the kernel rather than needing to compile it seperately all the
> > > time.  The patch, along with various other things, is included as
> > > part of my 2.4.21-rc1-erik kernel:
> > Are you sure that this is 0.9.2 ALSA? I am afraid it is 0.9.0-rc6.
> this looks _very_ similar to the patch I had in WOLK4 some time ago and it was 
> 0.9.0-rc6.

I finally got a bit of time this morning, so I have now updated
my patch set.  I check very carefully and made sure I generated
my ALSA 0.9.2 patch from the correct kernel tree this time, so 
it actually contains my 0.9.2 port this time.

    http://codepoet.org/kernel/

Sorry about having the wrong alsa patch in there last time.  Last
time around I has accidentlly built my alsa patch from my older
alsa kernel tree.  I have this built into my kernel and I now see 

    Partition check:
     hda: hda1 hda2
    Advanced Linux Sound Architecture Driver Version 0.9.2.
    PCI: Setting latency timer of device 00:11.5 to 64
    ALSA device list:
      #0: VIA 8233 at 0xcc00, irq 5

on bootup and xmms is playing.  Hope this is helpful,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

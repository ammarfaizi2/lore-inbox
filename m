Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTDOQ5C (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTDOQ5C 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:57:02 -0400
Received: from dnvrdslgw14poolC198.dnvr.uswest.net ([63.228.86.198]:58713 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id S261820AbTDOQ5B 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:57:01 -0400
Date: Tue, 15 Apr 2003 11:09:11 -0600 (MDT)
From: Benson Chow <blc@q.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ac97, alc101+kt8235 sound
In-Reply-To: <1050406611.27745.34.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304151057090.31225-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool, my ecs p4vxasd2+ (p4x333/kt8235/alc101) works with onboard sound
now.

What's the normal flow to get this added into ac97_codecs.c?

+        {0x414C4730, "ALC101",             &null_ops},

Adding this line into the table in ac97_codecs.c (with a few missing
#defines fixed... then I noticed they're already in -ac1 :) in
2.4.21-pre7 made sound work fine.

Now hopefully those of us who bought those Fry's "free" p4vxasd2+ 5.0's
can have sound.  I just mplayer'ed an avi with the new table entry and it
appears to work fine.  Volume controls look functional.  Will do some more
testing (record, etc.) tonight.

Thanks,

-bc

On 15 Apr 2003, Alan Cox wrote:

> Date: 15 Apr 2003 12:36:51 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Benson Chow <blc+lkml@q.dyndns.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: ac97, alc101+kt8235 sound
>
> On Maw, 2003-04-15 at 12:49, Benson Chow wrote:
> > hoping that these via chips were pretty close.  Unfortunately no, it
> > still doesn't work.  It did, however, find the AC97 codec fine (I added
> > some printk's), but no sound is produced.  Any ideas on how to get this
> > vt8235-based motherboard sound working?  (and ALSA-0.9.2 seems to do
> > nothing but segfault it seems.)
>
> See 2.4.21pre - that has the driver for VIA8233/5
>

WARNING: All HTML emails get deleted.  DO NOT SEND HTML MAIL.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRDQMmF>; Tue, 17 Apr 2001 08:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132587AbRDQMlz>; Tue, 17 Apr 2001 08:41:55 -0400
Received: from wb1-a.mail.utexas.edu ([128.83.126.134]:4100 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S132584AbRDQMlm>;
	Tue, 17 Apr 2001 08:41:42 -0400
Message-ID: <3ADC3A00.A9954E08@mail.utexas.edu>
Date: Tue, 17 Apr 2001 07:41:36 -0500
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.5-22smp i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dennis Bjorklund <db@zigo.dhs.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Slowdown for ATA/100 drive on PCI card, after 2.4.3upgrade.
In-Reply-To: <Pine.LNX.4.30.0104171408050.20942-100000@zigo.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis Bjorklund wrote:

> On Tue, 17 Apr 2001, Alan Cox wrote:
>
> > try and avoid a hardware problem. VIA have finally released an 'official'
> > fix which seems to be a lot less damaging to performance on the whole. That
> > I hope will be in 2.4.4
>
> What is this official fix? I've only seen unofficial ones (like the one in
> your ac7, or was it ac6). What are the implications of the fix
> (compabilitywise and speedwise)?
>
> I looked on via's homepage but could not find anything about this fix.
> I've very interested since I have a new mobo unopened in a box that I can
> still return and choose something with another chipset.

Notice that with 2.4.3 it *only* affects the disk on the PCI controller card; a
similar ATA/100 disk on the motherboard's controller did not experience the
slowdown.

Also, FYI, I noticed the mention of VIA fixes in the -ac7 change list, but those
changes did not cause or fix this particular problem.  The problem occurs in all
the 2.4.3's that I've tried: -ac5, -ac6, -ac7.

BTW, It's not hurting me right now, because the disk on the PCI card hasn't been
put to work yet.  I just want to make sure you guys are aware of it.

Bobby Bryant
Austin, Texas



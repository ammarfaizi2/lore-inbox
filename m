Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTFELz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTFELz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:55:56 -0400
Received: from haw-66-102-130-200.vel.net ([66.102.130.200]:6869 "HELO
	mx100.mysite4now.com") by vger.kernel.org with SMTP id S264632AbTFELzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:55:54 -0400
From: Udo Hoerhold <maillists@goodontoast.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.21-rc7-ac1
Date: Thu, 5 Jun 2003 08:08:19 -0400
User-Agent: KMail/1.5.2
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@fs.tum.de>
References: <200306042248.h54Mm7l16828@devserv.devel.redhat.com> <200306050124.20603.maillists@goodontoast.com> <1054810034.15276.13.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1054810034.15276.13.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306050808.19666.maillists@goodontoast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 June 2003 06:47 am, Alan Cox wrote:
> On Iau, 2003-06-05 at 06:24, Udo Hoerhold wrote:
> > On Wednesday 04 June 2003 06:48 pm, Alan Cox wrote:
> > > Linux 2.4.21rc7-ac1
> > > o	Fix ac97 build on SMP				(Adrian Bunk)
> >
> > It looks like ac97 on SMP is still broken.  On dual processor machine,
> > boot hangs with the last message displayed:
> >
> > Jun  5 01:17:58 frogmorton kernel: ac97_codec: AC97 Audio codec, id:
> > 0x8384:0x7609 (SigmaTel STAC9721/23)
> >
> > If I build kernel without SMP support, boot doesn't hang.
>
> What soundcard is this. That matters for debugging because the locking
> stuff is all on the soundcard not the codec side.

It's a SoundBlaster Live!  (no, I'm not really excited about it, that's the 
official way to spell it 8-))  emu10k1 is compiled as a module.

I can try it with a different sound card.  I have a Turtle Beach card around 
here somewhere that I think works.

Udo


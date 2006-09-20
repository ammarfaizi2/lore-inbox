Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWITIQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWITIQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 04:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWITIQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 04:16:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:2788 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750710AbWITIQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 04:16:35 -0400
From: Andi Kleen <ak@suse.de>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Date: Wed, 20 Sep 2006 10:16:08 +0200
User-Agent: KMail/1.9.3
Cc: billm@melbpc.org.au, billm@suburbia.net,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> <p73venk2sjw.fsf@verdi.suse.de> <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
In-Reply-To: <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609201016.08661.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 September 2006 23:14, Jesper Juhl wrote:
> On 19 Sep 2006 10:01:55 +0200, Andi Kleen <ak@suse.de> wrote:
> > "Jesper Juhl" <jesper.juhl@gmail.com> writes:
> >
> > > Hi,
> > >
> > > If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
> > > tried this with) and then boot the kernel with "no387" then I only get
> > > as far as lilo's "...Booting the kernel." message and then the system
> > > hangs.
> > >
> > > The kernel is a 32bit kernel build for K8 and my CPU is a Athlon64 X2 4400+
> >
> > Do you have a .config? I tried it and it booted until mounting root.
> >
> 
> The config is attached.

Still can't reproduce it unfortunately. I ran it on a fairly accurate 
Simulator and it seems to get until mounting root. It might depend 
on the compiler version though. I was using gcc 4.1.

-Andi

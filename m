Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264341AbRFOLYZ>; Fri, 15 Jun 2001 07:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264347AbRFOLYQ>; Fri, 15 Jun 2001 07:24:16 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:21008 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S264341AbRFOLYK>; Fri, 15 Jun 2001 07:24:10 -0400
Message-ID: <3B29F056.97C353C@damncats.org>
Date: Fri, 15 Jun 2001 07:24:06 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5-ac14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI-Devel <dri-devel@lists.sourceforge.net>,
        Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <20010615022033Z261561-17720+4111@vger.kernel.org> <3B29734A.738A95D5@damncats.org> <200106150442.AAA22505@spqr.damncats.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> Am Freitag, 15. Juni 2001 05:32 schrieb Dieter Nützel:
> > Am Freitag, 15. Juni 2001 04:30 schrieb John Cavan:
> > > Dieter Nützel wrote:
> > > > Hello Alan,
> > > >
> > > > I see 4.29 GB under shm with your latest try.
> > > > something wrong?
> > >
> > >         total:    used:    free:  shared: buffers:  cached:
> > > Mem:  1053483008 431419392 622063616   122880 24387584 260923392
> > > Swap: 394764288        0 394764288
> > > MemTotal:      1028792 kB
> > > MemFree:        607484 kB
> > > MemShared:         120 kB
> > > Buffers:         23816 kB
> > > Cached:         254808 kB
> > > Active:         225536 kB
> > > Inact_dirty:     53208 kB
> > > Inact_clean:         0 kB
> > > Inact_target:       44 kB
> > > HighTotal:      131056 kB
> > > HighFree:         1048 kB
> > > LowTotal:       897736 kB
> > > LowFree:        606436 kB
> > > SwapTotal:      385512 kB
> > > SwapFree:       385512 kB
> > >
> > > I don't seem to have the problem...
> >
> > You are using HIGHMEM?!

Sort of necessary when you have 1gb of RAM. My machine is also a dual
CPU box.

> I tested some more and found this.
> 
> It is XFree86 4.1.0 DRI (tdfx driver) related.
> During my first run I used the 2.4.5-ac14 kernel DRM module.
> Now I am running with the latest DRI trunk DRM module.
> Both show the same symptoms.

Well, I'm running XFree86 4.1.0 DRI with the Radeon driver and I don't
show the symptoms. I use the Radeon module from DRI on SourceForge.

Have you tried it with CONFIG_HIGHMEM in the kernel?

John

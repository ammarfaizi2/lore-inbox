Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRDCAOL>; Mon, 2 Apr 2001 20:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131756AbRDCAOB>; Mon, 2 Apr 2001 20:14:01 -0400
Received: from www.resilience.com ([209.245.157.1]:55795 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S129436AbRDCANx>; Mon, 2 Apr 2001 20:13:53 -0400
Message-ID: <3AC9086A.20E36D9F@resilience.com>
Date: Mon, 02 Apr 2001 16:16:58 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: Pete Zaitcev <zaitcev@redhat.com>, Ketil Froyn <ketil@froyn.com>,
   linux-kernel@vger.kernel.org
Subject: Re: oops in uhci.c running 2.4.2-ac28
In-Reply-To: <Pine.LNX.4.30.0104010313440.1135-100000@ns.froyn.org> <20010402185526.A4083@devserv.devel.redhat.com> <3AC8FDD8.4116E97@resilience.com> <20010402195048.H17651@sventech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:
> 
> On Mon, Apr 02, 2001, Jeff Golds <jgolds@resilience.com> wrote:
> > Let me show what I got with the 2.4.2 kernel with USB support enabled.
> >
> > Mar 19 14:10:00 Eng99 kernel: uhci: host controller halted. very bad
> > Mar 19 14:10:31 Eng99 last message repeated 108 times
> > Mar 19 14:11:37 Eng99 last message repeated 93 times
> > Mar 19 14:12:39 Eng99 last message repeated 87 times
> > Mar 19 14:13:40 Eng99 last message repeated 20 times
> > Mar 19 14:14:45 Eng99 last message repeated 42 times
> > Mar 19 14:15:46 Eng99 last message repeated 47 times
> > Mar 19 14:16:47 Eng99 last message repeated 127 times
> > Mar 19 14:17:50 Eng99 last message repeated 7074 times
> > Mar 19 14:18:51 Eng99 last message repeated 3342 times
> > Mar 19 14:19:52 Eng99 last message repeated 10948 times
> > Mar 19 14:20:00 Eng99 last message repeated 15
> > times
> >
> > This happens after simply fiddling around with ethernet settings (it's a
> > PCI ethernet card).  In fact, my syslog is FULL of these messages... my
> > syslog was 3x larger than usual.  The console is just about unusable
> > because of all the spam.
> >
> > Something seems terribly wrong with the uhci driver... I've disabled it
> > on my system and it's fine now (I don't need USB).
> 
> Do you get the same messages with the usb-uhci driver?
> 

Don't think I tried that one.

> > My system:
> > Slot 1 P3-850
> > VIA chipset MB (not sure of exact chipset, can find out if needed)
> 
> Some of the VIA chipsets have port aliasing problems supposedely. This
> may cause your controller to go insane like you've described.
> 
> JE
> 

That could explain the issue.  Fortunately, I don't need USB so I can
avoid the spam, I just thought someone might like to hear about it.

-Jeff

P.S.  Sorry for responding directly to you, Johannes.

-- 
Jeff Golds
jgolds@resilience.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311362AbSCWWCI>; Sat, 23 Mar 2002 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311367AbSCWWBs>; Sat, 23 Mar 2002 17:01:48 -0500
Received: from bazooka.saturnus.vein.hu ([193.6.40.86]:53910 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S311362AbSCWWBj>; Sat, 23 Mar 2002 17:01:39 -0500
Date: Sun, 24 Mar 2002 00:01:15 +0100
To: Steffen Persvold <sp@scali.com>
Cc: Janos Farkas <chexum@shadow.banki.hu>,
        Banai Zoltan <bazooka@enclavenet.hu>, linux-kernel@vger.kernel.org
Subject: Re: io-apic not working on i850mv(p4)
Message-ID: <20020324000115.C9229@bazooka.saturnus.vein.hu>
In-Reply-To: <priv$1016911429.lord@lk8rp.mail.xeon.eu.org> <Pine.LNX.4.30.0203232232240.11080-100000@elin.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Banai Zoltan <bazooka@enclavenet.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 10:34:57PM +0100, Steffen Persvold wrote:
> > > using 2.4.19-pre3-ac3 kernel with IO-APIC, but it seems not working to me:
> > >   0:    5420792          XT-PIC  timer
> > ...
> > > why gives XT-PIC instead of IO-APIC for all interrupst
> >
> > > Found and enabled local APIC!
> > ...
> > > Using local APIC timer interrupts.
> > > calibrating APIC timer ...
> > ...
> >
> > I/O APIC != local APIC; the latter is on on all CPU's since P5 (at least
> > for Intel), I/O APIC's are usable mostly on SMP boards.  Is yours SMP
> > capable?
> >
> 
> I don't think so, i850 & P4 is not SMP capable (Only P4 Xeon is). Maybe
> the kernel config is missing CONFIG_X86_UP_IOAPIC ?

Thats true, it is not SMP capable.
But my config contains CONFIG_X86_UP_IOAPIC=y

So the question is that if the local APIC shoud override the
XT-PIC routing? And if, why does not do it for me?

So my config misses that feature or there is a bug somewhere else?

Regards, Banai

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSDPVzC>; Tue, 16 Apr 2002 17:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313906AbSDPVzB>; Tue, 16 Apr 2002 17:55:01 -0400
Received: from [195.39.17.254] ([195.39.17.254]:28044 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S287817AbSDPVzA>;
	Tue, 16 Apr 2002 17:55:00 -0400
Date: Tue, 16 Apr 2002 10:02:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andy Pfiffer <andyp@osdl.org>, suparna@in.ibm.com,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <20020416100246.A37@toy.ucw.cz>
In-Reply-To: <1759496962.1018114339@[10.10.2.3]> <m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com> <m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com> <m1y9fvlfyb.fsf@frodo.biederman.org> <1018461522.4453.212.camel@andyp> <m1pu16l1c3.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The new device model from Pat (mochel@osdl.org) is probably the best way
> > to go here; you'll be able to walk the driver tree and reliably turn off
> > devices.
> 
> I totally agree.  Walking the driver tree is exactly what I want.
> Disabling bus masters is just a quick hack to rule out a DMA killing
> your linux booting linux.

Is there easy way to disable all busmasters? It might help suspend-to-disk
and suspend-to-ram to work well until  proper support is done...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131238AbRCOVVr>; Thu, 15 Mar 2001 16:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131311AbRCOVVh>; Thu, 15 Mar 2001 16:21:37 -0500
Received: from ns2.cypress.com ([157.95.67.5]:36264 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S131238AbRCOVVV>;
	Thu, 15 Mar 2001 16:21:21 -0500
Message-ID: <3AB1321B.ECBFFCEA@cypress.com>
Date: Thu, 15 Mar 2001 15:20:27 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
CC: pedwards@disaster.jaj.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: State of RAID (and the infamous FastTrak100 card)
In-Reply-To: <20010314155801.A7054@disaster.jaj.com> <20010314232714.A19404@unthought.net> <3AB12C4A.84152B20@gmx.at>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann wrote:
> 
> Jakob Østergaard wrote:
> > > So... am I just begging for pain if I try to install, say, a stock RH7
> > > on a machine with the FastTrak100 doing it's little RAID0/JBOD thing?
> > > If it requires this machine to always boot from a floppy because the driver
> > > cannot be linked into the kernel, well, I'm okay with that.
> >
> > I don't know about the state of the FastTrak100 IDE drivers - but if you can
> > get that running, putting software RAID on top of that should be a simple
> > matter.
> 
> I do not think that would work. These IDE RAID use a slightly different layout that someone would
> expect. This means that you cannot map it 1:1 to any RAID personality, therefore you cannot boot
> from it.
> 
> (Free)BSD supports this IDE RAID controller with the RAID functionality. Maybe you want to check it
> out.

Jakob ment the kernel software-RAID, md.0, raid0.o, raid1.o, raid5.o,
and linear.o
Not the Promise RAID software.

	-Thomas

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131813AbRCOUwg>; Thu, 15 Mar 2001 15:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131816AbRCOUw0>; Thu, 15 Mar 2001 15:52:26 -0500
Received: from pop.gmx.net ([194.221.183.20]:3053 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S131813AbRCOUwO>;
	Thu, 15 Mar 2001 15:52:14 -0500
Message-ID: <3AB12C4A.84152B20@gmx.at>
Date: Thu, 15 Mar 2001 21:55:38 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pedwards@disaster.jaj.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: State of RAID (and the infamous FastTrak100 card)
In-Reply-To: <20010314155801.A7054@disaster.jaj.com> <20010314232714.A19404@unthought.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard wrote:
> > So... am I just begging for pain if I try to install, say, a stock RH7
> > on a machine with the FastTrak100 doing it's little RAID0/JBOD thing?
> > If it requires this machine to always boot from a floppy because the driver
> > cannot be linked into the kernel, well, I'm okay with that.
> 
> I don't know about the state of the FastTrak100 IDE drivers - but if you can
> get that running, putting software RAID on top of that should be a simple
> matter.

I do not think that would work. These IDE RAID use a slightly different layout that someone would
expect. This means that you cannot map it 1:1 to any RAID personality, therefore you cannot boot
from it.

(Free)BSD supports this IDE RAID controller with the RAID functionality. Maybe you want to check it
out.
I want to write a kernel module for 2.4 which supports the HPT370 RAID. You can be sure that I will
peek at the FreeBSD code. In fact that is the only documentation I have.

Wilfried

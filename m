Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132653AbRDGOHG>; Sat, 7 Apr 2001 10:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132658AbRDGOGq>; Sat, 7 Apr 2001 10:06:46 -0400
Received: from endjinn.austria.eu.net ([193.81.13.2]:3025 "EHLO
	relay2.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132653AbRDGOGl>; Sat, 7 Apr 2001 10:06:41 -0400
Message-ID: <3ACF1ED6.6B1D2D96@eunet.at>
Date: Sat, 07 Apr 2001 16:06:14 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <3ACEFB05.C9C0AB3C@eunet.at> <20010407131631.A3280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Sat, Apr 07, 2001 at 01:33:25PM +0200, Michael Reinelt wrote:
> 
> > Adding PCI entries to both serial.c and parport_pc.c was that easy....
> 
> And that's how it should be, IMHO.  There needs to be provision for
> more than one driver to be able to talk to any given PCI device.

True, true, true.

But - how to deal with it? Who decides if we can deal this way or not?
PCI maintainer? Linus?

bye, Michael

P.S. I really need this. I have to unload serial and parallel and reload
them in different order when I want either print something or talk to my
Palm :-(

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at

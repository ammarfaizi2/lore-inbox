Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVLALhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVLALhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVLALhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:37:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17164 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932163AbVLALhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:37:53 -0500
Date: Thu, 1 Dec 2005 11:37:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, dwmw2@infradead.org,
       vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Message-ID: <20051201113744.GB19317@flint.arm.linux.org.uk>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, dwmw2@infradead.org,
	vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
References: <20051130190224.GE1053@flint.arm.linux.org.uk> <1133426199.4117.179.camel@baythorne.infradead.org> <20051201094111.GA14726@flint.arm.linux.org.uk> <20051201.015115.49187117.davem@davemloft.net> <20051201105227.GA19317@flint.arm.linux.org.uk> <58cb370e0512010311s77a57305w5e9c7294ec09900a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0512010311s77a57305w5e9c7294ec09900a@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 12:11:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/1/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Thu, Dec 01, 2005 at 01:51:15AM -0800, David S. Miller wrote:
> > > So, bad example.
> >
> > Not in the IDE case.  Bart restricted IDE to a smaller number of ARM
> > platforms, plus any that had PCMCIA.  There is no such restriction
> > in the asm-arm/*.h header files.
> 
> When I did this change there was such restriction in asm-arm/mach-*/ide.h
> files (some platforms just lacked ide.h making IDE build break for them).
> 
> IDE is a bad example anyway because of legacy ordering issues etc etc.

Okay.  Given the general concensus in this thread, can this be removed
now?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVCPUs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVCPUs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbVCPUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:48:26 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30128 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262791AbVCPUsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:48:22 -0500
Subject: Re: enabling IOAPIC on C3 processor?
From: Lee Revell <rlrevell@joe-job.com>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f60503160711137dbff3@mail.gmail.com>
References: <5a2cf1f6050315040956a512a6@mail.gmail.com>
	 <1110918157.17931.18.camel@mindpipe>
	 <5a2cf1f60503160711137dbff3@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 15:48:21 -0500
Message-Id: <1111006101.21604.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 16:11 +0100, jerome lacoste wrote:
> On Tue, 15 Mar 2005 15:22:36 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Tue, 2005-03-15 at 13:09 +0100, jerome lacoste wrote:
> > > I have a VIA Epia M10000 board that crashes very badly (and pretty
> > > often, especially when using DMA). I want to fix that.
> > >
> > 
> > Are the crashes associated with any particular workload or device?  My
> > M6000 works perfectly.
> > 
> > The one big problem I had with is is the VIA Unichrome XAA driver had a
> > FIFO related bug that caused it to stall the PCI bus, delaying
> > interrupts for tens of ms unless "Option NoAccel" was used.
> > 
> > This bug was fixed over 6 months ago though.
> 
> It crashes my box within minutes if not seconds when using mythtv
> (tuner using ivtv driver) while using my network card. If I disable
> DMA on the disk and don't use my card, it's much more stable (several
> hours without problem).
> 

Well, you might have better luck capturing the Oops with kdb.  At the
very least it might drop you into the debugger instead of locking up the
machine.

Lee


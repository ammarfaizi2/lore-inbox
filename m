Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbSKVAwa>; Thu, 21 Nov 2002 19:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbSKVAwa>; Thu, 21 Nov 2002 19:52:30 -0500
Received: from mail.cafes.net ([207.65.182.3]:53917 "EHLO mail.cafes.net")
	by vger.kernel.org with ESMTP id <S267242AbSKVAw3>;
	Thu, 21 Nov 2002 19:52:29 -0500
Date: Thu, 21 Nov 2002 18:53:55 -0600
From: Mike Eldridge <diz@cafes.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc2-xfs lockups
Message-ID: <20021121185355.A4376@ornery.cafes.net>
References: <20021121153122.B13338@ornery.cafes.net> <20021121172619.B13450@ornery.cafes.net> <1037925505.9160.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1037925505.9160.13.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 22, 2002 at 12:38:25AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 12:38:25AM +0000, Alan Cox wrote:
> On Thu, 2002-11-21 at 23:26, Mike Eldridge wrote:
> > On Thu, Nov 21, 2002 at 03:31:22PM -0600, Mike Eldridge wrote:
> > > i recently replaced a pII-350 with a pair of pIII-500s in a tyan
> > > S1836-DLUAN-GX board (440GX dual slot 1).  i'm now getting loads of NMI
> > > interrupts for unknown reasons (reasons 2c and 3c).
> > 
> > after more googling, i've found several pieces of information that seem
> > to suggest interrupt routing on 440GX-based motherboards is busted.
> > 
> > can anyone confirm this?  will booting with 'noapic' fix this problem?
> > am i doomed to run a UP kernel?
> 
> It varies. Unfortunately Intel won't tell us how to sort this mess out. 

hrm :/

ironically, i've got another box here (440GX dual pIII-500) running
linux-2.2.20 with apic enabled that doesn't have this problem.
interestingly, the NMI line from /proc/interrupts only lists counts for
CPU0, not for CPU1.  and it's sitting comfortably at 0.

running with 'noapic' on the troublesome machine still produces NMIs and
random hangs.

-mike

------------------------------------------------------------------------
   /~\  the ascii                "rich gifts wax poor when givers prove
   \ /  ribbon campaign                                         unkind"
    X   against html              -- ophelia (hamlet; act III, scene 1)
   / \  email!

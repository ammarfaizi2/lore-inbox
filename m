Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRDGFvm>; Sat, 7 Apr 2001 01:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132582AbRDGFvd>; Sat, 7 Apr 2001 01:51:33 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:39941
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132577AbRDGFvN>; Sat, 7 Apr 2001 01:51:13 -0400
Date: Fri, 6 Apr 2001 22:50:39 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.3 crashed my hard disk
In-Reply-To: <Pine.LNX.4.30.0104062244510.14947-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.10.10104062247360.5964-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Ion Badulescu wrote:

> On Fri, 6 Apr 2001, Andre Hedrick wrote:
> 
> > > You really ought to rename this parameter to pcibus. Even though it doesn't
> > > do justice to the VLB bus, the potential for user error is much smaller.
> > 
> > Until today you had a vaild point!
> > 
> > Promise Ultra100TX2 (20268 chipset).
> > 
> > This is a 66MHz clocked Ultra100 Chipset release this week.
> 
> Ok... but how does this invalidate my point? The 66MHz still applies to 
> the PCI bus, so pcibus is ok for the parameter name, no?

Because this card is designed to run in a 66MHz pcibus or standard 33MHz
pcibus, but the idebus/bridge is clocked at double pump or 1:1 depending
on the busses 64-bit/66MHz, 64-bit/33MHz, or 32-bit/33MHz

This is were it gets messy........so I do not have an answer that I valid
at this point, however I do know that 66MHz clocking is about to become
standard...

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com


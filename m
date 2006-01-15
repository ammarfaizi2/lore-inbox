Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWAOWrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWAOWrD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWAOWrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:47:03 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:55564 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750869AbWAOWrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:47:02 -0500
Date: Sun, 15 Jan 2006 23:46:42 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Roberto Nibali <ratz@drugphish.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20060115224642.GA10069@w.ods.org>
References: <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu> <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch> <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch> <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch> <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu> <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu> <Pine.LNX.4.64.0601151431250.5053@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601151431250.5053@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 02:38:51PM -0800, Chris Stromsoe wrote:
> On Sun, 15 Jan 2006, Chris Stromsoe wrote:
> >On Mon, 9 Jan 2006, Chris Stromsoe wrote:
> >>On Mon, 9 Jan 2006, Roberto Nibali wrote:
> >>
> >>>>That is the SCSI BIOS rev.  The machine is a Dell PowerEdge 2650 and 
> >>>>that's the onboard AIC 7899.  It comes up as "BIOS Build 25309".
> >>>
> >>>Brain is engaged now, thanks ;). If you find time, could you maybe 
> >>>compile a 2.4.32 kernel using following config (slightly changed from 
> >>>yours):
> >>>
> >>>http://www.drugphish.ch/patches/ratz/kernel/configs/config-2.4.32-chris_s
> >>
> >>If/when the current run with DEBUG_SLAB oopses, I'll reboot with the 
> >>config modifications.
> >
> >I've been running stable with the propsed changes since the 10th.  The 
> >original config and the currently running config are both at 
> ><http://hashbrown.cts.ucla.edu/pub/oops-200512/>.  This is the diff:
> 
> I made a mistake.
> 
> The machine was /not/ booted into that config.  It is running the original 
> config from http://hashbrown.cts.ucla.edu/pub/oops-200512/config-2.4.32 
> with DEBUG_SLAB defined and "pci=noacpi" passed in on the command line.
> 
> The config with HIGHIO disabled an ACPI=y has not been tested.

Thanks for the precision. So logically we should expect it to break sooner
or later ?

> 
> -Chris

Willy


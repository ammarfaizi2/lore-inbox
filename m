Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSACJ1D>; Thu, 3 Jan 2002 04:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbSACJ0y>; Thu, 3 Jan 2002 04:26:54 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:50186 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S285161AbSACJ0g>; Thu, 3 Jan 2002 04:26:36 -0500
Date: Thu, 3 Jan 2002 10:26:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103102625.A16652@suse.cz>
In-Reply-To: <20020102154633.A15671@thyrsus.com> <E16Lsn2-0005XV-00@the-village.bc.nu> <20020102160449.A16019@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020102160449.A16019@thyrsus.com>; from esr@thyrsus.com on Wed, Jan 02, 2002 at 04:04:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 04:04:49PM -0500, Eric S. Raymond wrote:

> > > What I want to do with this is make ISA-card questions invisible on modern
> > > PCI-only motherboards.
> > 
> > For the smart config I assume not in general ?
> 
> Right.  I'm well along on an autoconfigurator that can use the CML2 rulebase
> to do things like freezing to N all the symbols for PCI devices not explicitly 
> found by autoprobe.

Just note that a board without ISA slots can still have ISA devices
onboard, namely soundchips, and you still will want ISA drivers for those.

-- 
Vojtech Pavlik
SuSE Labs

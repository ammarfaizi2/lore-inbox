Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSC1AMo>; Wed, 27 Mar 2002 19:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSC1AMe>; Wed, 27 Mar 2002 19:12:34 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7942 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310749AbSC1AMP>; Wed, 27 Mar 2002 19:12:15 -0500
Date: Wed, 27 Mar 2002 16:11:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Itai Nahshon <nahshon@actcom.co.il>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Wakko Warner <wakko@animx.eu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
In-Reply-To: <200203280001.g2S01cb12720@lmail.actcom.co.il>
Message-ID: <Pine.LNX.4.10.10203271605170.6006-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Itai Nahshon wrote:

> On Thursday 28 March 2002 00:51 am, Alan Cox wrote:
> > > I have seen USB mass storage devices with ide connector on them, so it
> > > is certainly possible to translate between scsi and ide. If it makes
> > > sense from performance standpoint.... I don't know.
> 
> I have one of these. The performance that I get is really poor and there
> are some quirks but it is still useful. I will be _very happy_ when I will be 
> able to use it for system installation/upgrade (which did not happen yet).
> 
> >
> > SCSI->IDE command translation isnt too hard providing you stick to simple
> > stuff and blindly ignore things like ATAPI, SMART, and all the control
> > stuff. The moment you get into the complex stuff its deeply unfunny.
> >
> 
> What are the prospects of seeing SCSI and IDE code (and internal
> programming interface) unified? How much can be unified until
> performace considerations and code complexity mandates a separation?

Very easy if several issues are fixed, and that is the stumbling point.
I would require strict compliance to the standards, faking all the missing
parts of each transport layer, and abstraction of the all capabilties to a
comman caller/interface.

Oh and make every transport protocol support their own error recovery.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


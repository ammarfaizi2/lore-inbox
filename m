Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311239AbSCTChB>; Tue, 19 Mar 2002 21:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311270AbSCTCgv>; Tue, 19 Mar 2002 21:36:51 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:28932
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311239AbSCTCgl>; Tue, 19 Mar 2002 21:36:41 -0500
Date: Tue, 19 Mar 2002 18:36:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ken Brownfield <ken@irridia.com>, m.knoblauch@TeraPort.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP
In-Reply-To: <E16nVId-0000yr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203191834130.525-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Alan Cox wrote:

> > I am in their lab trying to reproduce the error and I have found some docs
> > which could help address the error of the 4byte FIFO issue in the engine.
> > It looks fixable on paper.
> 
> Andre - if you want the info I have from the previous stuff I was involved
> in I can strip out customer company info and send it on.
> 
> > As for the AMD driver, who knows which version is in that kernel.
> 
> 2.4.18 has a very old one
> 2.4.18-ac has the Andre/AMD updated one, but not the further updates.
> 		(eg it turns off SWDMA on more chipsets than it needs to)
> 

Why, SWDMA is obsoleted and there should not be any modern drives
reporting the support.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


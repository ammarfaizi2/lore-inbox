Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265933AbSKBLJM>; Sat, 2 Nov 2002 06:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265934AbSKBLJM>; Sat, 2 Nov 2002 06:09:12 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:41732 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265933AbSKBLJL>; Sat, 2 Nov 2002 06:09:11 -0500
Date: Sat, 2 Nov 2002 12:15:11 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] IDE BIOS timings, autotune cleanup
Message-ID: <20021102111511.GC1088@tmathiasen>
References: <20021102000219.GM1669@tmathiasen> <1036199577.14840.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036199577.14840.0.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Alan Cox wrote:
> On Sat, 2002-11-02 at 00:02, Torben Mathiasen wrote:
> > Hi,
> > 
> > The attached patch cleans up the 'autotune' concept used in the current 2.4
> > IDE driver. It also adds support for using pure BIOS IDE timings with DMA/PIO.
> > On some systems the BIOS has a far better overview on how things are connected
> > (some chipsets don't support >ata66 speed detection, etc).
> > 
> 
> Interesting idea. However you are working on whats effectively a dead
> codebase.

Oh :). Let me just port it over to AC and 2.5 for the new IDE layer. 

Torben

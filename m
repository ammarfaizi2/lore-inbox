Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSIWV7L>; Mon, 23 Sep 2002 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSIWV7L>; Mon, 23 Sep 2002 17:59:11 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:21189 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261506AbSIWV7J>;
	Mon, 23 Sep 2002 17:59:09 -0400
Date: Mon, 23 Sep 2002 15:04:17 -0700
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: Linux 2.5.38 [PATCH] IrDA
Message-ID: <20020923220417.GD12816@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com> <20020923152827.GB22333@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923152827.GB22333@titan.lahn.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 05:28:27PM +0200, Philipp Matthias Hahn wrote:
> Moin LKML, Jean!
> 
> On Sat, Sep 21, 2002 at 09:34:18PM -0700, Linus Torvalds wrote:
> > Jean Tourrilhes <jt@hpl.hp.com>:
> >   o More __FUNCTION__ cleanups for IrDA
> 
> More to find at http://pint.pmhahn.de/pmhahn/misc/irda-2.5.38.diff
> since it is too large (228099 Bytes) for LKML.
> 
> BYtE
> Philipp
> 
> PS: The magic "vim" like was
> %s!__FUNCTION__\s*\(\n\s*\)\?"\([^"]*"\(\s*\n\s*"[^"]*"\)\?\)\(\s*[,)]\)!\1"%s\2, __FUNCTION__ \4!

	Thanks a lot !
	I've merged your patch with other __FUNCTION__ stuff I already
had, split into manageable chunks and sent the result to Jeff Garzik
for inclusion. I'll follow up until it gets into the kernel...
	Regards,

	Jean

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTF0WCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTF0WCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:02:19 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:11492 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264870AbTF0WCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:02:03 -0400
Date: Sat, 28 Jun 2003 00:16:06 +0200
From: Manuel Estrada Sainz <ranty-bulk@ranty.pantax.net>
To: Pavel Roskin <proski@gnu.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       orinoco-devel@lists.sourceforge.net, jt@hpl.hp.com
Subject: Re: [Orinoco-devel] orinoco_usb Request For Comments
Message-ID: <20030627221605.GB1783@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030626205811.GA25783@ranty.pantax.net> <Pine.LNX.4.56.0306261734230.3732@marabou.research.att.com> <20030626225002.GA4703@ranty.pantax.net> <Pine.LNX.4.56.0306271736190.12316@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0306271736190.12316@marabou.research.att.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 05:49:59PM -0400, Pavel Roskin wrote:
> On Fri, 27 Jun 2003, Manuel Estrada Sainz wrote:
> 
> >  Actually, orinoco-exp could be used as a test bed for monitor mode,
> >  scanning, hermesap, ... and merge it back to the standard orinoco as it
> >  probes to work right. For now it should be a test bed for USB support :)
> [snip]
> > > If you are going to create a separate driver, you should rename the
> > > module.  I wouldn't bother with separate modules.  Just link hermes,
> > > orinoco and orinoco_usb to one driver, say orinoco-usb.
> >
> >  No, I want to stay as similar to standard orinoco as possible to make
> >  merging easier.
> 
> OK, I understand you are suggesting to fork an experimental branch.  Then
> I suggest that we stop this discussion in LKML and return to orinoco-devel
> to discuss the situation.
> 
> There is nothing wrong with the fork if all other ways to keep the code
> together have been exhausted.  But since this wasn't discussed in the
> orinoco-devel mailing list, I think it's too early to fork.
> 
> One thing we haven't considered is restructuring the code to separate
> common and different parts of the USB and the non-USB drivers.
> 
> The firmware issue has been solved in the 2.5 kernels, so it shouldn't
> prevent David from including your code.

 Monday the latest I'll start a thread in orinoco-devel, unless you do
 it first :) 

 Regards

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

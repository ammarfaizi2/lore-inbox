Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTF0Vfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbTF0Vfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:35:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:56223 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264806AbTF0Vfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:35:44 -0400
Date: Fri, 27 Jun 2003 17:49:59 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: ranty@debian.org
cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       orinoco-devel@lists.sourceforge.net, jt@hpl.hp.com
Subject: Re: [Orinoco-devel] orinoco_usb Request For Comments
In-Reply-To: <20030626225002.GA4703@ranty.pantax.net>
Message-ID: <Pine.LNX.4.56.0306271736190.12316@marabou.research.att.com>
References: <20030626205811.GA25783@ranty.pantax.net>
 <Pine.LNX.4.56.0306261734230.3732@marabou.research.att.com>
 <20030626225002.GA4703@ranty.pantax.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003, Manuel Estrada Sainz wrote:

>  Actually, orinoco-exp could be used as a test bed for monitor mode,
>  scanning, hermesap, ... and merge it back to the standard orinoco as it
>  probes to work right. For now it should be a test bed for USB support :)
[snip]
> > If you are going to create a separate driver, you should rename the
> > module.  I wouldn't bother with separate modules.  Just link hermes,
> > orinoco and orinoco_usb to one driver, say orinoco-usb.
>
>  No, I want to stay as similar to standard orinoco as possible to make
>  merging easier.

OK, I understand you are suggesting to fork an experimental branch.  Then
I suggest that we stop this discussion in LKML and return to orinoco-devel
to discuss the situation.

There is nothing wrong with the fork if all other ways to keep the code
together have been exhausted.  But since this wasn't discussed in the
orinoco-devel mailing list, I think it's too early to fork.

One thing we haven't considered is restructuring the code to separate
common and different parts of the USB and the non-USB drivers.

The firmware issue has been solved in the 2.5 kernels, so it shouldn't
prevent David from including your code.

-- 
Regards,
Pavel Roskin

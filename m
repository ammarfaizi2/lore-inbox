Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbTE1T6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264852AbTE1T6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:58:10 -0400
Received: from 4.54.252.64.snet.net ([64.252.54.4]:62352 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S264851AbTE1T6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:58:08 -0400
Message-ID: <3ED517E2.2010702@blue-labs.org>
Date: Wed, 28 May 2003 16:11:14 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030527
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Jakob Kemi <jakob.kemi@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 damaged my nvidia card?
References: <3ED4B42D.4040204@telia.com> <20030528132153.GA27632@suse.de>
In-Reply-To: <20030528132153.GA27632@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ATI card that went nuts a couple years ago, ~4 months old, 
fizzled on boot.  Doesn't work in text mode at all, works fine in 
graphics mode however.  I have an old ISA card stuck in the machine so 
the machine will boot.  The motherboard doesn't recognize the AGP card 
without another video card installed.  This is the only motherboard that 
I can get it to work on.  The card simply doesn't work at all on any 
other m/board.

Good thing I run Linux, I don't think I'd have this option under winblows ;)

David

Dave Jones wrote:

>On Wed, May 28, 2003 at 03:05:49PM +0200, Jakob Kemi wrote:
>
> > When I run the box with an old PCI card as my primary adapter and the 
> > AGP geforce card as secondary the Geforce card doesnt seem to run it's 
> > VGA BIOS (no boot message).
>
>most (if not all) modern BIOS's have an "Init {AGP/PCI} display first"
>option. You may need to fiddle with that.
> 
> > X also refuses to detect the Geforce card. 
> > Is it possible that the new console layer or the new agp gart code or 
> > whatever in 2.5.70 poked in the wrong registers and replaced the BIOS 
> > flash rom on the GeForce with garbage?
>
>Extremely unlikely. WRT agpgart, it pokes chipset registers, not
>graphic card registers.
>
>It may even be that the two cards you have won't play together.
>Try them both _independantly_ before jumping to conclusions about
>wiped BIOSes etc.
>
>		Dave
>  
>



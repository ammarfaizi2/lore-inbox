Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbTE1NsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264744AbTE1NsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:48:10 -0400
Received: from trinity.spray.se ([212.78.193.150]:25553 "EHLO trinity.spray.se")
	by vger.kernel.org with ESMTP id S264736AbTE1NsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:48:07 -0400
Message-ID: <3ED4C172.9020904@telia.com>
Date: Wed, 28 May 2003 16:02:26 +0200
From: Jakob Kemi <jakob.kemi@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: sv
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 damaged my nvidia card?
References: <3ED4B42D.4040204@telia.com> <20030528132153.GA27632@suse.de>
In-Reply-To: <20030528132153.GA27632@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your fast reply,

Dave Jones wrote:
> On Wed, May 28, 2003 at 03:05:49PM +0200, Jakob Kemi wrote:
> 
>  > When I run the box with an old PCI card as my primary adapter and the 
>  > AGP geforce card as secondary the Geforce card doesnt seem to run it's 
>  > VGA BIOS (no boot message).
> 
> most (if not all) modern BIOS's have an "Init {AGP/PCI} display first"
> option. You may need to fiddle with that.

Of course, but should't the AGP bios report itself during initialization 
even when 'Init PCI display first' is set, or is the legacy BIOS 
completely ignored on the secondary adapter?

>  > X also refuses to detect the Geforce card. 
>  > Is it possible that the new console layer or the new agp gart code or 
>  > whatever in 2.5.70 poked in the wrong registers and replaced the BIOS 
>  > flash rom on the GeForce with garbage?
> 
> Extremely unlikely. WRT agpgart, it pokes chipset registers, not
> graphic card registers.
> 
> It may even be that the two cards you have won't play together.
> Try them both _independantly_ before jumping to conclusions about
> wiped BIOSes etc.

The PCI card was installed afterwards to be able to use the computer at 
all since it now refuses to boot with the geforce card. I've tried to 
use the PCI card as the primary card and only use the geforce card with 
X to see if it'd work that way (which it didn't).

	/ Jakob Kemi


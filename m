Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVHCLO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVHCLO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVHCLOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:14:25 -0400
Received: from koto.vergenet.net ([210.128.90.7]:31638 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S261911AbVHCLOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:14:24 -0400
Date: Wed, 3 Aug 2005 19:40:08 +0900
From: Horms <horms@verge.net.au>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Chris Wright <chrisw@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] v4l cx88 hue offset fix
Message-ID: <20050803104007.GG23916@verge.net.au>
Mail-Followup-To: Michael Krufky <mkrufky@m1k.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
	Chris Wright <chrisw@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050802071959.GB22793@verge.net.au> <42EF69F7.2020108@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF69F7.2020108@m1k.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 08:41:27AM -0400, Michael Krufky wrote:
> Horms wrote:
> 
> >Hi Marcelo, 
> >
> >Another fix from 2.6.12.3 that seems approprite for 2.4.
> >Should apply cleanly to your tree.
> > 
> >
> Horms-
> 
> Thank you for the effort of trying to get this into 2.4, but I don't 
> think there is any support at all for cx88 cards in kernel 2.4 v4l.  I 
> wasn't involved in v4l back then, but I took a look at Marcelo's 
> linux-2.4.git/tree , and /drivers/media/video/cx88* just doesn't exist.  
> There is no cx88-video.c file present for this patch to be applied to!
> 
> This one-line fix does make a very big difference, but unfortunately, it 
> looks like 2.4 doesn't have the cx88 driver for the fixing...
> 
> Good to see that debian has backported it to their 2.6.8 kernel, 
> though.  That really makes me smile.  :-)

Sorry about the noise. Dann Frazier and I ran through a bunch of patches
from 2.6.12-stable to see which onese were appropriate for Debian's
2.4.27 and 2.6.8. This patch did indeed get backported to 2.6.8.
And in the course of juggling all the patches I made a mistake and added
it our 2.4.27 patchset and subsequently sent it here.

cx88 indeed is not in 2.4 and the patch is completely invalid for that
tree. Please ignore :)

I do have few other patches from 2.6.12-stable that do seem appropriate
for 2.4, but after this mess up I am waiting for all the builds to
finish before forwarding stuff on.

-- 
Horms

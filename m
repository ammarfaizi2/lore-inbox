Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbTGFQ2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbTGFQ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:28:18 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:45532 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266683AbTGFQ2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:28:17 -0400
Date: Sun, 6 Jul 2003 18:42:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomas Szepe <szepe@pinerecords.com>, Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
Message-ID: <20030706184242.A20851@ucw.cz>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net> <87fzllh21i.fsf@gitteundmarkus.de> <Pine.LNX.4.53.0307050956060.2029@mackman.net> <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk> <20030706090656.GA4739@louise.pinerecords.com> <1057482631.705.15.camel@dhcp22.swansea.linux.org.uk> <20030706111015.GA303@louise.pinerecords.com> <1057491491.1032.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1057491491.1032.0.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Jul 06, 2003 at 12:38:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 12:38:11PM +0100, Alan Cox wrote:
> On Sul, 2003-07-06 at 12:10, Tomas Szepe wrote:
> > Also note that when the '-X' switch is omitted (i.e. one only issues
> > "/usr/sbin/hdparm -d1 /dev/hdX"), the driver sets up a mode that doesn't
> > work and then quickly falls back to PIO.
> 
> Your BIOS has not tuned the drive for DMA either.

IMO the driver should do that in that case. There are way too many
broken BIOSes to make following what they decided to set up worthwhile.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

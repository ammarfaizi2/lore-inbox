Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272067AbTHNAWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTHNAWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:22:05 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:1987 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S272067AbTHNAWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:22:02 -0400
Date: Thu, 14 Aug 2003 02:21:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Lawrence <dgl@integrinautics.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: compact flash IDE hot-swap summary please
Message-ID: <20030814002146.GA2195@ucw.cz>
References: <3F1ECFDD.D561D861@integrinautics.com> <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 07:18:23PM +0100, Alan Cox wrote:
> On Mer, 2003-07-23 at 19:11, Dave Lawrence wrote:
> > I have a Zaurus handheld that runs Linux that seems 
> > to be able to hot-swap its IDE compact flash device
> > with no problems.  But I've read in a recent
> > thread "hdparm and removable IDE?" that hot-swap
> > isn't "fully" supported and that is won't be
> > until:
> 
> Thats hot swapping an IDE controller (built into the CF and
> PCMCIA stuff)

Is there any difference between pulling the controller out and the drive
out in the PCMCIA/CF case? I think there is not - since there is no
BMDMA engines, it boils down to just the command/nsect/chs registers,
which are in the drive.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbTFVTdj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbTFVTdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:33:39 -0400
Received: from windsormachine.com ([206.48.122.28]:1551 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S264904AbTFVTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:33:36 -0400
Date: Sun, 22 Jun 2003 15:47:40 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: xircom card bus with 2.4.20 link trouble
In-Reply-To: <1056195410.25975.1.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0306221545350.6572-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jun 2003, Alan Cox wrote:

> On Gwe, 2003-06-20 at 16:49, Mike Dresser wrote:
> > Now if only DMA mode would work on the Opti 621 chipset inside this
> > Omnibook 5500/5700 hybrid laptop :)  Then it wouldn't take 38 minutes to
> > compile.
>
> It should do - drivers/ide/pci/opti621.c

Indeed, I have it compiled in even.

Let me see if hte laptop is turned on currently.

Unfortunately, no.  But anyways, it does the classic error of {your drive}
{shouldn't do this}

and then disables DMA mode, and goes back to working.

It's an HP Omnibook 5700, and it's a Toshiba 1.3 gig drive in there.  I
don't remember if my Omnibook 5500 did it, and it's a pain to take the
donor screen back off the 5700 and putting it on the 5500 to try.

I had to disable "automatically enable DMA" for the laptop not to jam up
for a minute while it figures out the DMA mode isn't going to work.

It doesn't work in windows either for that matter, if I remember right the
option is completely greyed out.  Blacklist on windows?

I will check the exact lspci and hdparm -i when I get to the office
tomorrow.

Mike


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTFZTrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTFZTrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:47:04 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:48085 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263451AbTFZTrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:47:00 -0400
Date: Thu, 26 Jun 2003 22:01:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030626220109.B5633@ucw.cz>
References: <m2smqhqk4k.fsf@p4.localdomain> <20030615001905.A27084@ucw.cz> <m2he6rv8i6.fsf@telia.com> <20030615142838.A3291@ucw.cz> <m2of0zqr4i.fsf@telia.com> <20030615192731.A6972@ucw.cz> <m2d6hbgdhw.fsf@telia.com> <pan.2003.06.23.16.30.42.431561@dungeon.inka.de> <m2isqwr4yh.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m2isqwr4yh.fsf@telia.com>; from petero2@telia.com on Mon, Jun 23, 2003 at 09:04:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 09:04:06PM +0200, Peter Osterlund wrote:
> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
> 
> > I tried that driver with 2.5.73. The synaptics option is gone, so it is
> > always on by default? No way to turn it off?
> 
> Correct. I don't know if it was an accident or if it was an
> intentional decision, but there doesn't seem to be a way to make the
> touchpad operate in relative (compatibility) mode any more.

It was an intention, because we need the full support to make the
secondary (passthrough) devices work properly. However, now that I've
seen all the bug reports I think it probably wasn't a good decision.

> On the other hand, I don't think there will be any reason to use
> relative mode once we have X and gpm support for absolute mode, and
> when guest devices are supported.

We need GPM support very soon.

> Yes, use the synclient program to tweak parameters until you find a
> setting you like. (I use MinSpeed=0.08 and MaxSpeed=0.10). Then put
> them in the XF86Config file. The INSTALL file has an example
> InputDevice section that you may want to start from.
> 
> I've seen X freeze too. I'll debug it, but it will have to wait a week
> until I get back from my vacation.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

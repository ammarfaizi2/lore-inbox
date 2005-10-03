Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVJCPBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVJCPBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVJCPBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:01:37 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:45572 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750916AbVJCPBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:01:36 -0400
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LVM and lilo: a problem!
References: <433F2A30.6080308@esoterica.pt>
From: Nix <nix@esperi.org.uk>
X-Emacs: if it payed rent for disk space, you'd be rich.
Date: Mon, 03 Oct 2005 16:01:11 +0100
In-Reply-To: <433F2A30.6080308@esoterica.pt> (Paulo da Silva's message of "2
 Oct 2005 01:33:44 +0100")
Message-ID: <87slvir6fc.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Oct 2005, Paulo da Silva gibbered uncontrollably:
> However, I needed to run lilo and got the
> following message:
> 
> Warning: '/proc/partitions' does not match '/dev' directory structure.
>     Name change: '/dev/dm-0' -> '/dev/VSDB/gtpalma'
> 
> '/dev/VSDB/gtpalma' is a logical volume I created and is
> working fine anyway.
> 
> What does this mean?

LILO assumes that names in /proc/partitions correspond one-to-one with
names in /dev. This assumption isn't true under LVM (and need not be
true in any circumstances: you can rearrange disks in any way you
like with udev, and a number of distributions do).

> Should I do anything to avoid the message?

As far as I know, it's harmless.

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll

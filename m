Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271336AbRIAUd7>; Sat, 1 Sep 2001 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271347AbRIAUdt>; Sat, 1 Sep 2001 16:33:49 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:29514 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S271336AbRIAUdd>; Sat, 1 Sep 2001 16:33:33 -0400
Date: Sat, 1 Sep 2001 15:33:49 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why is tulip in its own directory (at least to 2.4.8) ?
In-Reply-To: <Pine.LNX.4.21.0108312031320.711-100000@pppg_penguin.linux.bogus>
Message-ID: <Pine.LNX.3.96.1010901153238.27935B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001, Ken Moffat wrote:
> I've just changed the NIC on my main box from a natsemi to a tulip. The
> natsemi module was in /lib/modules/`uname -r`/kernel/drivers/net along
> with the ppp modules, but the tulip module is in a tulip subdirectory.
> 
> Is there a good reason for this ?

A sane organization.  At least two more tulip-alikes are moving into
that directory in 2.5, even though they will remain separate drivers.

"8390" and "lance" sub-directories are also coming in 2.5.

	Jeff




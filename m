Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSHGUNE>; Wed, 7 Aug 2002 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSHGUNE>; Wed, 7 Aug 2002 16:13:04 -0400
Received: from host179.debill.org ([64.245.56.179]:33471 "EHLO mail.debill.org")
	by vger.kernel.org with ESMTP id <S313202AbSHGUNC>;
	Wed, 7 Aug 2002 16:13:02 -0400
Date: Wed, 7 Aug 2002 15:16:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ethtool documentation
Message-ID: <20020807201642.GA11100@debill.org>
References: <Pine.LNX.4.44.0208062318350.4696-100000@mooru.gurulabs.com> <Pine.LNX.3.95.1020807070841.28061A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020807070841.28061A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
From: erik@debill.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 07:18:17AM -0400, Richard B. Johnson wrote:
> 
> That capability is not permanent. If you let users write to the
> SEEPROM, permanently changing the IEEE Station Address, you have
> let users permanently break their network boards. I do protest
> when this capability is in the kernel.

Don't forget the old sun workstations that keep MAC addresses in
nvram, where it's setable via the boot prom.  I had one with a bad
battery that I had to reset the MAC address on by hand if I unplugged
it for too long.

They DID implement a check to make sure the first few bits were
correct for the product, though.  I couldn't pick completely random
MACs (though C0FFEE fit nicely at the end).

Given a working nvram, this change was "permanent", and the only tools
needed came with the system.



Erik

-- 
Ask not what your computer can do for you.  Ask what you can do for
  your computer.

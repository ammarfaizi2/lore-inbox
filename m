Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbTLRSg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 13:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTLRSg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 13:36:56 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:6272
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265250AbTLRSgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 13:36:55 -0500
Date: Thu, 18 Dec 2003 13:36:07 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lennert Buytenhek <buytenh@gnu.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.0 keyboard not working
In-Reply-To: <20031218182117.GA31558@gnu.org>
Message-ID: <Pine.LNX.4.58.0312181334150.1710@montezuma.fsmlabs.com>
References: <20031218060053.GA645@gnu.org> <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com>
 <20031218145434.GA20303@gnu.org> <20031218150431.GA20543@gnu.org>
 <Pine.LNX.4.58.0312181129260.1710@montezuma.fsmlabs.com> <20031218182117.GA31558@gnu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Lennert Buytenhek wrote:

> On Thu, Dec 18, 2003 at 11:30:27AM -0500, Zwane Mwaikambo wrote:
>
> > Thanks Lennert, could you try without CONFIG_HIGHMEM64G, perhaps just
> > CONFIG_HIGHMEM4G, how much memory in the system? dmesg also would be nice.
>
> Hi Zwane, I just finished checking, and without highmem and with HIGHMEM4G
> it works just fine, only with 64G I get the 'Unknown key pressed' flood which
> I described.  I had 64G on because I copied my .config from Arjan's 2.6 RPMs,
> none of which worked on this machine because of those keyboard troubles.  The
> box has 1G of RAM.

Thanks for testing that, Dan Creswell <dan@dcrdev.demon.co.uk> mentioned a
similar problem with an e7505 Tyan board he has too.

> Thanks!  Anything else I can try?

I'd love to see dmesg and /proc/iomem for CONFIG_HIGHMEM4G and
CONFIG_HIGHMEM64G.

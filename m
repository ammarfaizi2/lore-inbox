Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269034AbUIHDkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269034AbUIHDkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUIHDkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:40:18 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:1960 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269030AbUIHDj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:39:58 -0400
Message-ID: <9e473391040907203941e4af81@mail.gmail.com>
Date: Tue, 7 Sep 2004 23:39:49 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: multi-domain PCI and sysfs
Cc: willy@debian.org, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040907161140.29fbfccc.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041527.50136.jbarnes@engr.sgi.com>
	 <9e47339104090415451c1f454f@mail.gmail.com>
	 <200409041603.56324.jbarnes@engr.sgi.com>
	 <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
	 <9e473391040905165048798741@mail.gmail.com>
	 <20040906014058.GV642@parcelfarce.linux.theplanet.co.uk>
	 <9e47339104090715585fa4f8af@mail.gmail.com>
	 <20040907161140.29fbfccc.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004 16:11:40 -0700, David S. Miller <davem@davemloft.net> wrote:
> On Tue, 7 Sep 2004 18:58:53 -0400
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > How many active VGA devices can I have in this system 1 or 4? If the
> > answer is 4, how do I independently address each VGA card? If the
> > answer is one, you can see why I want a pci0000 node to hold the
> > attribute for turning it off and on.
> 
> I don't know about the above but for a multi-domain system the
> way it works is that the I/O ports are accessed using a different
> base address for each domain.

How does this work for IO ports in port space instead of memory mapped IO?

-- 
Jon Smirl
jonsmirl@gmail.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbRCIWhM>; Fri, 9 Mar 2001 17:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130730AbRCIWhC>; Fri, 9 Mar 2001 17:37:02 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:23815 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130721AbRCIWgq>; Fri, 9 Mar 2001 17:36:46 -0500
Date: Fri, 9 Mar 2001 17:34:40 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: "David S. Miller" <davem@redhat.com>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        linux-usb-devel@lists.sourceforge.net,
        Manfred Spraul <manfred@colorfullife.com>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
Message-ID: <20010309173440.A21429@devserv.devel.redhat.com>
In-Reply-To: <00d401c0a5c6$f289d200$6800000a@brownell.org> <20010305232053.A16634@flint.arm.linux.org.uk> <15012.27969.175306.527274@pizda.ninka.net> <055e01c0a8b4$8d91dbe0$6800000a@brownell.org> <3AA91B2C.BEB85D8C@colorfullife.com> <15017.7950.106874.276894@pizda.ninka.net> <20010309133502.R31345@sventech.com> <06a701c0a8d1$199377e0$6800000a@brownell.org> <15017.14312.932929.194773@pizda.ninka.net> <071c01c0a8dd$e0ac4940$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <071c01c0a8dd$e0ac4940$6800000a@brownell.org>; from david-b@pacbell.net on Fri, Mar 09, 2001 at 01:14:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 09 Mar 2001 13:14:03 -0800
> From: David Brownell <david-b@pacbell.net>

>[...]
> It feels to me like you're being inconsistent here, objecting
> to a library API for some functionality (mapping) yet not for
> any of the other functionality (alignment, small size, poisoning
> and so on).  And yet when Pete Zaitcev described what that
> mapping code actually involved, you didn't object.  So you've
> succeeded in confusing me.  Care to unconfuse?

I did not propose an API or library which would be equal amond equals
with first rate citizens of pci_alloc_xxx and friends. I pointed out
that driver can do tracking of reverse mappings at very little cost
by using offset [Alan remarked to that how hash can use page number];
so, one may say that I supported DaveM's viewpoint. No wonder he did
not object.

-- Pete

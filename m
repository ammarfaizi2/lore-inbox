Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbTCTWO7>; Thu, 20 Mar 2003 17:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262652AbTCTWO7>; Thu, 20 Mar 2003 17:14:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20485 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262651AbTCTWO6>;
	Thu, 20 Mar 2003 17:14:58 -0500
Date: Thu, 20 Mar 2003 14:26:11 -0800
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: David Brownell <david-b@pacbell.net>, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI MWI cacheline size fix
Message-ID: <20030320222611.GC4607@kroah.com>
References: <20030320135950.A2333@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320135950.A2333@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 01:59:50PM +0300, Ivan Kokshaysky wrote:
> This is rather conservative variant of previous patch:
> - no changes required for drivers or architectures with HAVE_ARCH_PCI_MWI;
> - do respect BIOS settings: if the cacheline size is multiple
>   of that we have expected, assume that this is on purpose;
> - assume cacheline size of 32 bytes for all x86s except K7/K8 and P4.
>   Actually it's good for 386/486s as quite a few PCI devices do not support
>   smaller values.
> 
> If you all are fine with it, I can make a 2.4 counterpart.

This looks fine to me.

thanks,

greg k-h

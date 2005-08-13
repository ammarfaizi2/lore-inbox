Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVHMXnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVHMXnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 19:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVHMXnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 19:43:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:54187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932412AbVHMXnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 19:43:31 -0400
Date: Sun, 14 Aug 2005 01:43:22 +0200
From: Olaf Hering <olh@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Henrik Brix Andersen <brix@gentoo.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050813234322.GA30563@suse.de>
References: <1123969015.13656.13.camel@sponge.fungus> <20050813232519.GA20256@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050813232519.GA20256@infradead.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Aug 14, Christoph Hellwig wrote:

> On Sat, Aug 13, 2005 at 11:36:55PM +0200, Henrik Brix Andersen wrote:
> > Here's a patch for unifying the watchdog device node name
> > to /dev/watchdog as expected by most user-space applications.
> > 
> > Please CC: me on replies as I am not subscribed to LKML.
> 
> Please don't.  misdevice.name is a description of the device, and doesn't
> have any relation with the name of the device node.

It is used for /class/misc/$name/dev

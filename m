Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbTANQwU>; Tue, 14 Jan 2003 11:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTANQwU>; Tue, 14 Jan 2003 11:52:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264702AbTANQwT>;
	Tue, 14 Jan 2003 11:52:19 -0500
Date: Tue, 14 Jan 2003 09:59:31 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Tigran Aivazian <tigran@veritas.com>, Christoph Hellwig <hch@lst.de>,
       Hugh Dickins <hugh@veritas.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
In-Reply-To: <1042563017.1401.2.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.33.0301140958391.1025-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Jan 2003, Arjan van de Ven wrote:

> On Tue, 2003-01-14 at 17:32, Tigran Aivazian wrote:
> 
> > If you move it all the way to sysfs (i.e. no device node in /dev) then it
> > seems a bit odd that a device driver entry point is found somewhere other
> > than the usual /dev.
> 
> well
> 
> cat firmware > /sys/processor/0/microcode

Out of curiosity, how large are the microcode updates? Or rather, what is 
the range of sizes that you've seen?


	-pat


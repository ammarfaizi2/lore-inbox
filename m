Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290219AbSAORxI>; Tue, 15 Jan 2002 12:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290212AbSAORwu>; Tue, 15 Jan 2002 12:52:50 -0500
Received: from air-1.osdl.org ([65.201.151.5]:54664 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290213AbSAORvw>;
	Tue, 15 Jan 2002 12:51:52 -0500
Date: Tue, 15 Jan 2002 09:53:27 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Greg KH <greg@kroah.com>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Defining new section for bus driver init
In-Reply-To: <20020115050512.GA24580@kroah.com>
Message-ID: <Pine.LNX.4.33.0201150951131.827-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I like it.  Are you going to want to move the other busses to this
> (sbus, mca, ecard, zorro, etc.)?

Yes, though I don't have a way to test them...

> Don't add USB to the list of busses that should be
> moved to this scheme, it works just fine today in the initcall section
> (after pci starts up.)

Ok, fine. My main concern was to remedy the root buses of the system. I
don't believe that USB is such a thing, except maybe on some ARM systems?

	-pat


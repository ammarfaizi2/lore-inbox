Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265927AbUA0Uyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUA0Uyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:54:53 -0500
Received: from ns.suse.de ([195.135.220.2]:3468 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265927AbUA0Uym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:54:42 -0500
Date: Tue, 27 Jan 2004 21:54:40 +0100
From: Andi Kleen <ak@suse.de>
To: George Anzinger <george@mvista.com>
Cc: jim.houston@comcast.net, akpm@osdl.org, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
Message-Id: <20040127215440.7bdea8ae.ak@suse.de>
In-Reply-To: <4016CC1C.8020709@mvista.com>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
	<20040127155619.7efec284.ak@suse.de>
	<1075225399.1020.239.camel@new.localdomain>
	<20040127190251.4edb873d.ak@suse.de>
	<1075232116.1020.326.camel@new.localdomain>
	<4016CC1C.8020709@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 12:37:48 -0800
George Anzinger <george@mvista.com> wrote:

> If we are going to use DEBUG_INFO could we change the "-g" it produces to 
> "-gdwarft-2", especially since you (and I) are using dwarft2 CFI stuff.

On x86-64 dwarf2 is default (and the only supported debug format anyways)
I believe any modern i386 gcc does that same. It would probably only 
make a difference to a few people still using ancient compilers.

-Andi

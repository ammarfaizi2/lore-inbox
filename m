Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264005AbUKZVSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbUKZVSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUKZUTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:19:15 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:60106 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S263968AbUKZT5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:57:35 -0500
Date: Fri, 26 Nov 2004 02:04:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@novell.com>, davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041126010423.GI5904@dualathlon.random>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain> <20041125150206.GF16633@logos.cnet> <20041125203248.GD5904@dualathlon.random> <20041125171242.GL16633@logos.cnet> <20041125231313.GG5904@dualathlon.random> <20041125194509.GN16633@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125194509.GN16633@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 05:45:09PM -0200, Marcelo Tosatti wrote:
> Oh the VM_IO enforcement has been there for ages.

VM_IO is there for ages, but it wasn't used by all drivers, this is why
we got the problem... ;)

> Sure, I'll comment the BUG() off during 2.4.29-rc.
> 
> How does that sound?

Sounds good ;)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbULALJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbULALJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 06:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbULALJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 06:09:23 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:65118 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261362AbULALJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 06:09:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=r4t0WsXSIuFC0xALVeVZ7tirfUb7wsmAOC7KM8m/g24ogqJTl2ypiihWj0ls6bRb8N6epGfKAQvPmrC5ZkmT6EJR00gepchxA2yL35NPv+1zGG63TOFJkUM5dbMGm+4MxnMVx3FZOfp/UosNHaarNPDD9Bw90DNB0S79BcgIjm8=
Message-ID: <40f323d0041201030969c5dd92@mail.gmail.com>
Date: Wed, 1 Dec 2004 12:09:19 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.10-rc2-mm3 [was: Re: 2.6.9-rc2: "kernel BUG at mm/rmap.c:473!"]
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Kirk <mike.kirk@sympatico.ca>
In-Reply-To: <20041201011046.GY4365@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041130150639.GA11294@ens-lyon.fr>
	 <Pine.LNX.4.44.0412010028460.3344-100000@localhost.localdomain>
	 <20041201011046.GY4365@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004 02:10:46 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Wed, Dec 01, 2004 at 12:49:39AM +0000, Hugh Dickins wrote:
> > The atomic counter underflow in do_exit does suggest corruption
> > elsewhere than in transcode's page table (though I'm not at all
> > sure that is corrupt) - as always, it is worth giving memtest86
> > a thorough run to check your memory.
> 
> Transcode should be 99% cpu bound in userspace and it shouldn't be
> kernel intensive at all. It's one of the few desktop apps 99% cpu bound,
> in turn the reasoning that the cpu is overheating sounds reasonable to
> me. It might also be using sse2 to compress faster etc...
> 

I just did a memtest86 and it reported errors. It looks like my
hardware is faulty here.
Sorry for the inconvenience.

regards,

Benoit

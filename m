Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSJUNqu>; Mon, 21 Oct 2002 09:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSJUNqu>; Mon, 21 Oct 2002 09:46:50 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:20916 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261375AbSJUNqr>; Mon, 21 Oct 2002 09:46:47 -0400
Subject: Re: [PATCH] Add generic prefetch xor routines
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021017172729.GA29177@suse.de>
References: <20021017180134.X15163@parcelfarce.linux.theplanet.co.uk> 
	<20021017172729.GA29177@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 15:08:32 +0100
Message-Id: <1035209312.27309.121.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 18:27, Dave Jones wrote:
> Won't this prefetch past the end of the buffer ?
> Some CPUs have problems with prefetching non-existant areas
> of RAM iirc. (Which is why the memcpy routines do a prefetching
> loop, and then a non prefetching loop to copy the tail).

Yes I reported this to Matthew ages ago, but its not been fixed. Thats
why I've not been merging that change anywhere.


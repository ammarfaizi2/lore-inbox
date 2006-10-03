Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWJCLFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWJCLFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWJCLFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:05:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55682 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030301AbWJCLFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:05:11 -0400
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061002213809.7a3f995f.rdunlap@xenotime.net>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <p73venk2sjw.fsf@verdi.suse.de>
	 <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
	 <20061002191638.093fde85.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
	 <20061002213809.7a3f995f.rdunlap@xenotime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 12:30:33 +0100
Message-Id: <1159875034.17553.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 21:38 -0700, ysgrifennodd Randy Dunlap:
> OK, how about something more direct and less obtrusive, like this?
> 
> ---
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Honor "nofxsr" boot option during init.
> Eliminates the math fault during boot.

Why not just check the flags we set early on to indicate we have a real
FPU instead of another boot option ?


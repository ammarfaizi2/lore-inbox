Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWJDVpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWJDVpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWJDVpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:45:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:30385 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751168AbWJDVpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:45:05 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Date: Wed, 4 Oct 2006 23:44:51 +0200
User-Agent: KMail/1.9.3
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> <9a8748490610041302i2bc4d1aave8fbc3e6c153759b@mail.gmail.com> <1159999240.25772.121.camel@localhost.localdomain>
In-Reply-To: <1159999240.25772.121.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610042344.51206.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 00:00, Alan Cox wrote:
> Ar Mer, 2006-10-04 am 22:02 +0200, ysgrifennodd Jesper Juhl:
> > > > /etc/rc.d/rc.sshd: line 4: 1491 Illegal instruction    /usr/sbin/sshd
> > >
> > > Ok, I bet you have your sshd compiled to use MMX instructions
> > > unconditionally.
> > >
> > Probably, I haven't checked.
> 
> Or we aren't correctly masking all the other cpuid bits we should in
> this case..

It might be using CPUID directly which can't be masked

-Andi


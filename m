Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285465AbRLGMAC>; Fri, 7 Dec 2001 07:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285468AbRLGL7w>; Fri, 7 Dec 2001 06:59:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33545 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285465AbRLGL7m>; Fri, 7 Dec 2001 06:59:42 -0500
Subject: Re: Linux/Pro  -- clusters
To: dalecki@evision.ag
Date: Fri, 7 Dec 2001 12:08:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3C10A057.BD8E1252@evision-ventures.com> from "Martin Dalecki" at Dec 07, 2001 11:56:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CJnv-0005c0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > major/minors for old stuff still end up leaking into user space and
> > mattering there. I'm not sure the best option for that
> 
> Thta's no problem. But they should be used as hash values no the
> syscall implementation level and nowhere else.

We have apps that "know" about specific major/minors that need changing and
will take time - also some of them are closed source so unfixable.

For new stuff that bit isnt an issue, although ioctl overlaps mean we have
some other problems to worry about there

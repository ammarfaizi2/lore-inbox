Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289201AbSBEHBl>; Tue, 5 Feb 2002 02:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289230AbSBEHBb>; Tue, 5 Feb 2002 02:01:31 -0500
Received: from [217.7.28.131] ([217.7.28.131]:60430 "EHLO inetgate.hob.de")
	by vger.kernel.org with ESMTP id <S289201AbSBEHB0>;
	Tue, 5 Feb 2002 02:01:26 -0500
Message-ID: <3C5F80F2.54AF98E3@hob.de>
Date: Tue, 05 Feb 2002 07:51:30 +0100
From: Christian Hildner <christian.hildner@hob.de>
Organization: hob electronic
X-Mailer: Mozilla 4.78 [de]C-CCK-MCD DT  (WinNT; U)
X-Accept-Language: de
MIME-Version: 1.0
To: Jes Sorensen <jes@sunsite.dk>
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] kmalloc() size-limitation
In-Reply-To: <3C3D6A89.27EAA4C7@hob.de> <15421.61910.163437.45726@napali.hpl.hp.com> <3C3ED5E7.8BA479B7@hob.de> <15423.5404.65155.924018@napali.hpl.hp.com> <3C43D6EC.74B4EC85@hob.de> <d31yg1lzgm.fsf@lxplus052.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen schrieb:

> Christian Hildner <christian.hildner@hob.de> writes:
>
> > David,
> >
> > you proposed me to use alloc_pages() instead of kmalloc() in order
> > to get memory bigger than the 128K limit of the kmalloc() call. But
> > even driver-developers don't want to handle with the page struct
> > unless this is unavoidable. Which are the disadvantages of
> > increasing the size limit of kmalloc() to 256K, 512K or 1M since
> > machines are getting bigger and 64Bit machines break with current
> > memory limitations?
>
> Because drivers needs to work on all architectures and relying on
> different hahavior from kmalloc() is bad.
>
> Jes

Jes,

sorry for being unclear. I mean from increasing the kmalloc() size-limit
all platforms would benefit.

Christian

PS: David, I am looking forward getting your book. You are doing a great
job.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129646AbQJaHGM>; Tue, 31 Oct 2000 02:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbQJaHGC>; Tue, 31 Oct 2000 02:06:02 -0500
Received: from www.wen-online.de ([212.223.88.39]:28165 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129219AbQJaHFs>;
	Tue, 31 Oct 2000 02:05:48 -0500
Date: Tue, 31 Oct 2000 08:03:57 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.4.21.0010301439080.16609-100000@duckman.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10010310800490.951-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Rik van Riel wrote:

> On Mon, 30 Oct 2000, Richard B. Johnson wrote:
> 
> > How much memory would it be reasonable for kmalloc() to be able
> > to allocate to a module?
> 
> > There are 256 megabytes of SDRAM available. I don't think it's
> > reasonable that a 1/2 megabyte allocation would fail, especially
> > since it's the first module being installed.
> 
> If you write the defragmentation code for the VM, I'll
> be happy to bump up the limit a bit ...

Hmm.. Bill Hawes wrote a memory defragger a long time ago.  I have a
copy of it lying around if you want to take a look at it.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

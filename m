Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276864AbRJHMNm>; Mon, 8 Oct 2001 08:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276870AbRJHMNd>; Mon, 8 Oct 2001 08:13:33 -0400
Received: from apollos.ttu.ee ([193.40.254.143]:37895 "EHLO apollos.ttu.ee")
	by vger.kernel.org with ESMTP id <S276864AbRJHMNa>;
	Mon, 8 Oct 2001 08:13:30 -0400
Date: Mon, 8 Oct 2001 14:13:46 +0200 (EET)
From: david <david@apollos.ttu.ee>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI problem with 2.4.10 on 82434LX chipset
In-Reply-To: <9pqr52$7fu$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110081412540.9299-100000@apollos.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.33.0110072319040.2878-100000@apollos.ttu.ee>,
> david  <david@apollos.ttu.ee> wrote:
> >
> >PCI: PCI BIOS revision 2.10 entry at 0xfd6f2, last bus=0
> >PCI: System does not support PCI
> >
> >Any hope getting PCI bus working on this box? Maybe some hints? Thanx :)
>
> The type-2 config space accesses were broken in 2.4.10 due to an ACPI
> rewrite, that got fixed in the 2.4.11-pre kernels (should be fixed in
> pre1 already, but you might as well test pre5).
>
> Most people never noticed, because type 1 tends to be what most machines
> use.
>
> The 2.4.11 kernels are under ftp.kernel.org:/pub/linux/kernel/testing,
>

Yep, pre* patch worked too, thanx :)

Taavi Tuisk


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274117AbSITAOc>; Thu, 19 Sep 2002 20:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274118AbSITAOb>; Thu, 19 Sep 2002 20:14:31 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:37533 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S274117AbSITAOY>; Thu, 19 Sep 2002 20:14:24 -0400
Date: Thu, 19 Sep 2002 19:35:12 -0400
From: Nicholas <TheUnforgiven@attbi.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
Message-Id: <20020919193512.31f3d8c9.TheUnforgiven@attbi.com>
In-Reply-To: <87znuhxn80.fsf@enki.rimspace.net>
References: <1032180131.1191.7.camel@irongate.swansea.linux.org.uk>
	<20020916.121423.109699832.davem@redhat.com>
	<8765x5z9go.fsf@enki.rimspace.net>
	<20020916.182924.50846771.davem@redhat.com>
	<87znuhxn80.fsf@enki.rimspace.net>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002 14:18:55 +1000
Daniel Pittman <daniel@rimspace.net> wrote:

> On Mon, 16 Sep 2002, David S. Miller wrote:
> >    From: Daniel Pittman <daniel@rimspace.net>
> >    Date: Tue, 17 Sep 2002 11:33:11 +1000
> > 
> >    ...which might explain why my machine has occasional DRM related
> >    hangs, since there is no way for me to match the XFree86 AGP speed
> >    and the BIOS set AGP speed -- my BIOS will not tell me what it set,
> >    nor does it have a toggle to adjust it.
> > 
> > There's a value in the PCI config space, check out the AGP gart
> > code in the kernel.  I don't know it offhand.
> 
> lspci -vv shows the details of it, in case anyone else is wondering what
> their AGP bridge is configured for. Now to see if that solves my DRI
> hangs...
> 
>         Daniel
> 
> -- 
> A psychatrist is someone who hopefully finds out what
> makes a person tick before they explode.
>         -- Alfred E. Neuman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




It fixed ALL of my lockups and open gl works.  Sorry to post this originally to the list ithought it was a kernel bug :(

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315446AbSEBVxO>; Thu, 2 May 2002 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEBVxN>; Thu, 2 May 2002 17:53:13 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:22286 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S315446AbSEBVxN>;
	Thu, 2 May 2002 17:53:13 -0400
Date: Thu, 2 May 2002 15:52:53 -0600 (MDT)
From: Kurt Ferreira <kurdt@nmt.edu>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <20020502212810.GN32767@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0205021549480.618-100000@eldorado.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 02, 2002 at 03:20:39PM -0700, Martin J. Bligh wrote:
> > IIRC, there are some funny games you can play with 32bit PCI DMA.
> > You're not necessarily restricted to the bottom 4Gb of phys addr space,
> > you're restricted to a 4Gb window, which you can shift by programming
> > a register on the card. Fixing that register to point to a window for the
> > node in question allows you to allocate from a node's pg_data_t and
> > assure DMAable RAM is returned.
> > M.
>
>
> Woops, I forgot about the BAR, thanks. Heck, IIRC you were even the one
> who told me about this trick.
>
By this do you mean setting bits BAR[2:1]=b'10?  Just making sure I get
it.

Thanks
Kurt



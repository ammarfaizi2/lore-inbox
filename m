Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSEANTF>; Wed, 1 May 2002 09:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSEANTE>; Wed, 1 May 2002 09:19:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53851 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312296AbSEANTE>; Wed, 1 May 2002 09:19:04 -0400
Date: Wed, 1 May 2002 09:18:02 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in "page_alloc.c" with 2.4.19-pre7-ac2
Message-ID: <20020501091802.A6679@devserv.devel.redhat.com>
In-Reply-To: <3CCFE83F.B858A101@redhat.com> <Pine.GSO.4.44.0205011409070.1714-100000@gerber>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 02:11:33PM +0100, Alastair Stevens wrote:
> > > Basically, "page_alloc.c" generated a BUG error when unmounting my
> > > filesystems during a reboot. I wasn't able to capture the full output,
> > > but I hope may be useful to report this anyway. If it happens again I'll
> > > try to grab the details....
> >
> > Are you using the nvidia driver by chance ?
> 
> Umm, yes, as it happens. Forgive my non-kernel hacking ignorance, but I
> didn't draw an obvious connection between these things! If it's
> somehow the fault of the nVidia driver, then I know enough not to
> complain to l-k :-)

90% or more of the times such a BUG happens nvidia
is involved. Maybe not scientific proof but a good indication.

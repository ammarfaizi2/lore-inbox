Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSBWNQW>; Sat, 23 Feb 2002 08:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293134AbSBWNQM>; Sat, 23 Feb 2002 08:16:12 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:15958 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S293133AbSBWNQC>; Sat, 23 Feb 2002 08:16:02 -0500
Date: Sat, 23 Feb 2002 13:16:19 +0000
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Boot problem with PDC20269
Message-ID: <20020223131619.A2603@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10202221953470.3281-100000@master.linux-ide.org> <3C778797.3BC039A@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C778797.3BC039A@gmx.net>; from gunther.mayer@gmx.net on Sat, Feb 23, 2002 at 13:14:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002, Gunther Mayer wrote:

> Andre Hedrick wrote:
> 
> > Hi Adam,
> >
> > http://www.tecchannel.de/hardware/817/index.html
> >
> > We do not put ATAPI devices on such HOSTS.
> 
> put == support ?
> 

I wasn't clear enough in my original mail - the ATAPI device is on the
VIA southbridge, not the Promise card.  The two drives on the Promise
card are hde and hdg.

> >
> > The driver will not work w/ ATAPI there because it uses a different DMA
> > engine location and is not supported in Linux.
> 
> It is a serious bug in the IDE driver to hang the system (and not the user's
> fault).
> 
> A fix would be to printk("The linux IDE driver does not (yet?)support ATAPI
> devices on PDC20269. Ignoring the device.\n");
> and continue running.
> 
> -
> Gunther
> 

At this stage I'm not all that bothered about the performance issues, I
just want to be able to use the two drives.

Thanks for the replies,
Adam

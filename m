Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293194AbSBWUS1>; Sat, 23 Feb 2002 15:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293195AbSBWUSR>; Sat, 23 Feb 2002 15:18:17 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53230
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293194AbSBWUSK>; Sat, 23 Feb 2002 15:18:10 -0500
Date: Sat, 23 Feb 2002 12:18:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Gunther Mayer <gunther.mayer@gmx.net>
Cc: Andre Hedrick <andre@linuxdiskcert.org>, Adam Huffman <bloch@verdurin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot problem with PDC20269
Message-ID: <20020223201827.GK20060@matchmail.com>
Mail-Followup-To: Gunther Mayer <gunther.mayer@gmx.net>,
	Andre Hedrick <andre@linuxdiskcert.org>,
	Adam Huffman <bloch@verdurin.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10202221953470.3281-100000@master.linux-ide.org> <3C778797.3BC039A@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C778797.3BC039A@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 01:14:15PM +0100, Gunther Mayer wrote:
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

I agree.

Andre, what about southbridges that have these chipsets built in?

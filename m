Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136119AbRAHSG1>; Mon, 8 Jan 2001 13:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136568AbRAHSGG>; Mon, 8 Jan 2001 13:06:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38298 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135995AbRAHSFv>;
	Mon, 8 Jan 2001 13:05:51 -0500
Date: Mon, 8 Jan 2001 13:05:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stefan Traby <stefan@hello-penguin.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010108172225.A1391@stefan.sime.com>
Message-ID: <Pine.GSO.4.21.0101081304380.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Stefan Traby wrote:

> On Mon, Jan 08, 2001 at 04:01:10PM +0000, Alan Cox wrote:
> > > I prefer SuS fpathconf(), pathconf() is just a wrapper to fpathconf();
> > 
> > You can't implement it that way in the corner cases.
> 
> I reread SuSv2 again and didn't found corner cases.
> Do you mean FIFO/pipe stuff ? I can't see the problem in this area.
> 
> In which case is an emulation of pathconf by fpathconf impossible ?

Damnit, symlinks for one thing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

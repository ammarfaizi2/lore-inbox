Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274573AbRJAF1p>; Mon, 1 Oct 2001 01:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274574AbRJAF1g>; Mon, 1 Oct 2001 01:27:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62432 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274573AbRJAF12>;
	Mon, 1 Oct 2001 01:27:28 -0400
Date: Mon, 1 Oct 2001 01:27:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
In-Reply-To: <20010930222210.A24037@codepoet.org>
Message-ID: <Pine.GSO.4.21.0110010126001.14026-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Sep 2001, Erik Andersen wrote:

> On Sun Sep 30, 2001 at 06:31:55PM -0400, Alexander Viro wrote:
> > 
> > 	One thing that doesn't work yet is support of Acorn partitions -
> > I'm switching it to pagecache right now.
> 
> Well, acorn is broken anyways....  Try enabling in on a device
> with native 2048 byte sectors and _no_ partition table will be
> found on those devices (just an error msg resulting from acorn)

Could you send me an example of such animal?  I don't mean the disk itself -
just the contents of relevant sectors (i.e. everything except the contents
of partitions themselves).


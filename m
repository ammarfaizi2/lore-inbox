Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRAHSeR>; Mon, 8 Jan 2001 13:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRAHSeH>; Mon, 8 Jan 2001 13:34:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12490 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129706AbRAHSd5>;
	Mon, 8 Jan 2001 13:33:57 -0500
Date: Mon, 8 Jan 2001 13:33:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stefan Traby <stefan@hello-penguin.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010108192455.A1891@stefan.sime.com>
Message-ID: <Pine.GSO.4.21.0101081332460.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Stefan Traby wrote:

> On Mon, Jan 08, 2001 at 01:22:49PM -0500, Alexander Viro wrote:
> 
> > Here's another one: suppose that /foo is a mountpoint and you have
> > no read permissions on it. Try to open the thing...
> 
> I would return EACCESS.
> [EACCES]
>           Search permission is denied for a component of the path prefix.

And prefix would be what? "/"? Besides, I said that you don't have
read permissions on /foo, not search ones.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

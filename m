Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132209AbQLHQnt>; Fri, 8 Dec 2000 11:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132271AbQLHQnj>; Fri, 8 Dec 2000 11:43:39 -0500
Received: from 62-6-231-79.btconnect.com ([62.6.231.79]:9476 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S132209AbQLHQnb>;
	Fri, 8 Dec 2000 11:43:31 -0500
Date: Fri, 8 Dec 2000 16:13:30 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Daniel Phillips <phillips@innominate.de>
cc: caperry@edolnx.net, linux-kernel@vger.kernel.org
Subject: Re: Kernel Development Documentation?
In-Reply-To: <00120816515701.00491@gimli>
Message-ID: <Pine.LNX.4.21.0012081607290.921-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Daniel Phillips wrote:
> Tigran Aivazian has been preparing 'Linux Kernel Internals' which is
> *highly recommended* and 100% free.  

in case he is curious where to find it:

http://www.moses.uklinux.net/patches/lki.html

(or .sgml for master source).

Interestingly, the main problem with LKI turned out to be _not_ the issue
of keeping it uptodate but filling in the missing bits, most notably
buffer cache and page cache. By now I more or less actually understand the
Linux buffer cache (only after diligent comparison with UW7, AIX, OSR5 and
many other commercial UNIX implementations whose source code is available)
but still not the page cache (even after reading everything about it that
I could find, including recent Understanding Linux Kernel book by Bovet
which I just finished reading). E.g. it is not even obvious to me that
things will get any worse if one throws away the entire readahead logic
from the page cache.

So, if someone wants to write a chapter on Linux page cache and contribute
it to the LKI book (and thus become a co-author :) please feel free -- it
will be a proof that someone in the world actually understands it -- at
the moment I doubt that very much... Take it as a challenge :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

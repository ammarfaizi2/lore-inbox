Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132383AbRASPLu>; Fri, 19 Jan 2001 10:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131629AbRASPLj>; Fri, 19 Jan 2001 10:11:39 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:21779 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S131466AbRASPLe>;
	Fri, 19 Jan 2001 10:11:34 -0500
Message-ID: <3A68591B.417EC21E@holly-springs.nc.us>
Date: Fri, 19 Jan 2001 10:11:23 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mo McKinlay <mmckinlay@gnu.org>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101191455570.2331-100000@nvws005.nv.london>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mo McKinlay wrote:

> openstream(file, stream, flags)
> 
> Where 'file' should be an fd (although i'm sure the VFS gods will think of
> plenty of reasons why this is a bad idea, at which point I'll
> conventiently change my mind ;). Stream is simply the name of the stream,
> flags are as with open() (O_RDONLY, et al). openstream() then returns an
> fd which can be read/written/sendfiled/closed as the programmer wishes.

I'm not opposed to that, and think it is even a useful idea. Sort of
like fdopen().

> Apart from the additional of a new open()-type call, your paper seems to
> be fairly solid.

Thanks. I think having the option of the namespace augmentation would be
useful, in terms of supporting existing filesystems. On NTFS, ":" is not
a legal filename character anyway. The namespace augmentation suggested
in the paper would allow filesystems like NTFS to work as they should,
and all other filesystems to ignore it.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRADFPt>; Thu, 4 Jan 2001 00:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132823AbRADFPj>; Thu, 4 Jan 2001 00:15:39 -0500
Received: from waste.org ([209.173.204.2]:16145 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129436AbRADFPe>;
	Thu, 4 Jan 2001 00:15:34 -0500
Date: Wed, 3 Jan 2001 23:15:31 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
In-Reply-To: <Pine.GSO.4.21.0101032355040.19195-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0101032309050.1971-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Alexander Viro wrote:

> > I bet it long predates dcache though..
>
> Not too likely. <checking CVS> It went in in 2.1.93. Apr 2 1998...
> Dcache was there ~50 versions before that.

Huh. Is there anything that prevents fragmentation in, say, growing
maildirs, where there's nothing but locality to hold the directory inode
in cache?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

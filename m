Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285389AbRLNPHD>; Fri, 14 Dec 2001 10:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285390AbRLNPGx>; Fri, 14 Dec 2001 10:06:53 -0500
Received: from web12305.mail.yahoo.com ([216.136.173.103]:57606 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285389AbRLNPGg>; Fri, 14 Dec 2001 10:06:36 -0500
Message-ID: <20011214150635.93222.qmail@web12305.mail.yahoo.com>
Date: Fri, 14 Dec 2001 07:06:35 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: [PATCH] cciss 2.5.0 for 2.5.1-pre11
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig (hch@ns.caldera.de) wrote:

> In article <20011211151050.12948.qmail@web12308.mail.yahoo.com> you wrote:
> >
> > Here's a patch for the cciss driver in the 2.5.1-pre8 tree
> > (patch also applies to 2.5.1-pre9): <
> > http://geocities.com/dotslashstar/cciss_2.5.0_for_2.5.1-pre8.txt
> >
> > This patch:
> >
> > * adds support for SCSI tape drives. 
> > * adds support for dynamically adding and removing      
> > logical volumes on the fly.
> 
> * sets hardsectsizes to '0' for invalid volumes, causing devisions by zero
>    in ll_rw_block().

I think I fixed this. (thanks for the patch).

> * backs out random fixes done in the mainline

I can't see what you mean here.  What "random fixes" are 
you referring to? 
.
Here is a new patch against 2.5.1-pre11:
http://www.geocities.com/smcameron/cciss_2.5.0_for_2.5.1-pre11.patch.gz

-- steve





__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com

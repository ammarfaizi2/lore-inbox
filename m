Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWFIRNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWFIRNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWFIRNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:13:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27876 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030313AbWFIRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:13:43 -0400
Subject: Re: [RFC 0/13] extents and 48bit ext3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060609154238.GN1651@parisc-linux.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <20060609091327.GA3679@infradead.org>
	 <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org>
	 <20060609154238.GN1651@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 18:29:13 +0100
Message-Id: <1149874154.22124.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-09 am 09:42 -0600, ysgrifennodd Matthew Wilcox:
> Hang on, you're going too far.  You have to enable extents with the
> extent mount option.  Otherwise you don't get to use them.  The user
> does, in fact, have a clear division, although maybe the blinky signs
> aren't quite luminous enough.

<mba marketing>
I'd rather the blinky sign was "ext4". It makes it clear it is a
progression and it also gives everyone something to put in the features
box and talk to the press about 8)
</mba>

> I still think making ext3 bigger than 16TB is just silly.

We recently fixed a 'If the disk is 4TB in size the geometry reporting
breaks and parted crashes' bug. The stuff is out there and people want
to run ext3 on it or an ext3 derivative they feel they trust. Does it
matter whether it is the most optimal solution, that'll sort itself out
as ext3.5/ext4, reiser4, jfs, xfs etc get picked and demanded by users

Alan


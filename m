Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266112AbUAGAtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 19:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUAGAtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 19:49:40 -0500
Received: from [193.138.115.2] ([193.138.115.2]:27397 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S266112AbUAGAtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 19:49:39 -0500
Date: Wed, 7 Jan 2004 01:46:25 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Hans Reiser <reiser@namesys.com>
cc: Mike Fedyk <mfedyk@matchmail.com>,
       "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>,
       linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
In-Reply-To: <3FFB441D.3010908@namesys.com>
Message-ID: <Pine.LNX.4.56.0401070140050.8521@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk>
 <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk>
 <20040106174650.GD1882@matchmail.com> <Pine.LNX.4.56.0401062251290.8384@jju_lnx.backbone.dif.dk>
 <3FFB441D.3010908@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Hans Reiser wrote:

> Jesper Juhl wrote:
>
> >
> >Also, I did a build of fs/reiserfs/ both with and without the above patch,
> >and then did a disassemble of inode.o (objdump -d) and compared the
> >generated code for reiserfs_get_block , and the generated code is
> >byte-for-byte identical in both cases, which means that gcc realizes that
> >the if() statement will never execute and optimizes it away in any case.
> >
> >
> I think you have done too much work.;-)
>
> Thanks though.
>
You are very welcome. I'm having great fun reading the code, looking
for potential problems, testing stuff etc..
I'm enjoying myself (and learning along the way, which is good :).

> The only reason we are slow in processing your patch and forwarding it
> to Linus is that the Russian Christmas is today....
>
Enjoy :-)


/Jesper Juhl


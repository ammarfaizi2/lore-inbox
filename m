Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUKFJo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUKFJo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUKFJo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:44:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:52419 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261348AbUKFJoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:44:24 -0500
Date: Sat, 6 Nov 2004 09:43:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Willy Tarreau <willy@w.ods.org>
cc: Hua Zhong <hzhong@cisco.com>, "'Grzegorz Kulewski'" <kangur@polcom.net>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Chris Wedgwood'" <cw@f00f.org>, "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Adam Heath'" <doogie@debian.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <20041106083824.GB783@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0411060939580.2721-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004, Willy Tarreau wrote:
> On Fri, Nov 05, 2004 at 02:08:45PM -0800, Hua Zhong wrote:
> > At least in 2.4.17 I couldn't loopback mount an (ext2) image from tmpfs and
> > had to use ramfs. Has this been fixed?

Yes, fixed in 2.4.22.

> I believe it works now (2.4.27) but at least some external add-ons such as
> Tux cannot serve pages on tmpfs but are OK on ramfs.

Oh, I thought that was fixed at the same time in 2.4.22.
Seems nobody complained it wasn't.  Probably easily done,
but really too late now to be adding features to 2.4.
The 2.6 tmpfs has no problem there, does it?

Hugh


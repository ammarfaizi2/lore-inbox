Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUCPIBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUCPIBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:01:42 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:49103 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263419AbUCPIBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:01:30 -0500
Date: Tue, 16 Mar 2004 07:30:28 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040316063028.GA24008@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075814.GE31818@MAIL.13thfloor.at> <20040315141004.7b386661.akpm@osdl.org> <20040315230405.GA19403@MAIL.13thfloor.at> <20040315153153.2d23a652.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315153153.2d23a652.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 03:31:53PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > > Could you please work that with Andreas?
> > 
> > sure, Andreas who?
> 
> Andreas Gruenbacher <agruen@suse.de>

okay, will contact him ...

> > > IS_RDONLY_INODE() is also used in intermezzo, but that doesn't compile any
> > > more anyway.
> > 
> > so I do not bother with that, but what about the nfs(d)
> > stuff? 

> er, what nfs stuff?  Your patches only have IS_RDONLY_INODE() being used in
> the ext2/3 xattr code and in intermezzo.

hmm, I guess nfsd_permission() can be considered nfs stuff,
but I'll look into that anyway, maybe Trond can help here ...
(patch-2.6.4-20040314_2308-bme0.04.1-ro3.diff 5/5)

best,
Herbert

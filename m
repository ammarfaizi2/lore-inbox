Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbUCOXa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbUCOXaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:30:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:52688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262964AbUCOX3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:29:54 -0500
Date: Mon, 15 Mar 2004 15:31:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-Id: <20040315153153.2d23a652.akpm@osdl.org>
In-Reply-To: <20040315230405.GA19403@MAIL.13thfloor.at>
References: <20040315035506.GB30948@MAIL.13thfloor.at>
	<20040314201457.23fdb96e.akpm@osdl.org>
	<20040315042541.GA31412@MAIL.13thfloor.at>
	<20040314203427.27857fd9.akpm@osdl.org>
	<20040315075814.GE31818@MAIL.13thfloor.at>
	<20040315141004.7b386661.akpm@osdl.org>
	<20040315230405.GA19403@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> > Could you please work that with Andreas?
> 
> sure, Andreas who?

Andreas Gruenbacher <agruen@suse.de>

> > IS_RDONLY_INODE() is also used in intermezzo, but that doesn't compile any
> > more anyway.
> 
> so I do not bother with that, but what about the nfs(d)
> stuff? 

er, what nfs stuff?  Your patches only have IS_RDONLY_INODE() being used in
the ext2/3 xattr code and in intermezzo.

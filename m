Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUBJGgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUBJGgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:36:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:6370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265659AbUBJGgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:36:03 -0500
Date: Mon, 9 Feb 2004 22:38:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: mfedyk@matchmail.com, linux-kernel@vger.kernel.org
Subject: Re: 4.1GB limit with nfs3, 2.6 & knfsd?
Message-Id: <20040209223841.70befa8a.akpm@osdl.org>
In-Reply-To: <16424.29172.314124.933554@notabene.cse.unsw.edu.au>
References: <20040210043926.GG18674@srv-lnx2600.matchmail.com>
	<20040209215020.60cf2f93.akpm@osdl.org>
	<16424.29172.314124.933554@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> > write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = -1 EINVAL (Invalid argument)
>  > 
> 
>  This is probably fixed by the following patch that is sitting in my
>  queue.

Indeed it is, thanks.

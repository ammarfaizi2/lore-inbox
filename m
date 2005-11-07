Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVKGV3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVKGV3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVKGV3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:29:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965154AbVKGV3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:29:10 -0500
Date: Mon, 7 Nov 2005 13:28:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Ashutosh Naik <ashutosh_naik@adaptec.com>, pablo@eurodev.net,
       tgraf@suug.ch, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [PATCH] lib - Fix broken function declaration in
 linux/textsearch.h
In-Reply-To: <20051107201200.GA23160@kroah.com>
Message-ID: <Pine.LNX.4.64.0511071328150.3247@g5.osdl.org>
References: <1131363741.30115.35.camel@localhost.localdomain>
 <20051107201200.GA23160@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Nov 2005, Greg KH wrote:

> On Mon, Nov 07, 2005 at 05:12:21PM +0530, Ashutosh Naik wrote:
> > This PATCH addresses the issue of the init function pointer in
> > lib/ts_bm.c, lib/ts_fsm.c and lib/ts_kmp.c using a mismatching
> > definition in linux/textsearch.h
> > 
> > 
> > Signed-off-by: Ashutosh Naik <ashutosh.naik@adaptec.com>
> 
> Is this upstream?

Yes, it's in the standard kernel. Whether it needs to be in the stable one 
or not, I don't know. It certainly doesn't match the requirements (it just 
removes a couple of compile warnings).

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVKGVvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVKGVvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVKGVvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:51:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:22228 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965185AbVKGVvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:51:18 -0500
Date: Mon, 7 Nov 2005 13:49:39 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ashutosh Naik <ashutosh_naik@adaptec.com>, pablo@eurodev.net,
       tgraf@suug.ch, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [PATCH] lib - Fix broken function declaration in linux/textsearch.h
Message-ID: <20051107214939.GB25058@kroah.com>
References: <1131363741.30115.35.camel@localhost.localdomain> <20051107201200.GA23160@kroah.com> <Pine.LNX.4.64.0511071328150.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511071328150.3247@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:28:57PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 7 Nov 2005, Greg KH wrote:
> 
> > On Mon, Nov 07, 2005 at 05:12:21PM +0530, Ashutosh Naik wrote:
> > > This PATCH addresses the issue of the init function pointer in
> > > lib/ts_bm.c, lib/ts_fsm.c and lib/ts_kmp.c using a mismatching
> > > definition in linux/textsearch.h
> > > 
> > > 
> > > Signed-off-by: Ashutosh Naik <ashutosh.naik@adaptec.com>
> > 
> > Is this upstream?
> 
> Yes, it's in the standard kernel. Whether it needs to be in the stable one 
> or not, I don't know. It certainly doesn't match the requirements (it just 
> removes a couple of compile warnings).

Ok, it's dropped.

thanks,

greg k-h

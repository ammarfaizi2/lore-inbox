Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266050AbUBCREt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbUBCREt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:04:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:61888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266050AbUBCREs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:04:48 -0500
Date: Tue, 3 Feb 2004 09:04:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: <200402031025.i13APFvl023035@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0402030901150.11083@home.osdl.org>
References: <200402031025.i13APFvl023035@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Feb 2004, Roland McGrath wrote:
>
> This patch is working for me.  What do you think?

I think it looks ok, and makes sense. I don't see anything wrong with it, 
so if we put it in -mm for a while to test, and nobody else can see any 
gotcha's with it..

		Linus

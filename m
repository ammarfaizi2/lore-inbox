Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUBVDXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUBVDXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:23:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:2536 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261661AbUBVDXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:23:04 -0500
Date: Sat, 21 Feb 2004 19:28:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
In-Reply-To: <20040222031113.GB13840@dingdong.cryptoapps.com>
Message-ID: <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com>
 <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
 <20040222031113.GB13840@dingdong.cryptoapps.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004, Chris Wedgwood wrote:
> 
> Maybe gradual page-cache pressure could shirnk the slab?

What happened to the experiment of having slab pages on the (in)active
lists and letting them be free'd that way? Didn't somebody already do 
that? Ed Tomlinson and Craig Kulesa?

That's still something I'd like to try, although that's obviously 2.7.x 
material, so not useful for rigth now.

Or did the experiment just never work out well?

		Linus

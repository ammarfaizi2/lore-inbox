Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUBTFxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 00:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUBTFxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 00:53:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:23248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267536AbUBTFxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 00:53:35 -0500
Date: Thu, 19 Feb 2004 21:58:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BK PATCH] USB update for 2.6.3
In-Reply-To: <20040220012802.GA16523@kroah.com>
Message-ID: <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Greg KH wrote:
> 
> Here are some USB patches for 2.6.3.  Here are the main types of changes:
> 	- switch usb code to use dmapools instead of pcipools which
> 	  makes the embedded people happy.

However, this makes the ppc64 people very unhappy.

I've just yesterday and today switched my main home machine to be ppc64, 
and this will not compile for me. Bad boy!

(And I haven't used ppc64 enough to be able to make sense of the DMA 
setup, so I can't even fix it myself yet. Aaarghh!)

Help me, Obi Wan.

		Linus

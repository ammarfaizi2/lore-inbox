Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTL2Suy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTL2Suy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:50:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:2694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263927AbTL2Sux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:50:53 -0500
Date: Mon, 29 Dec 2003 10:50:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
In-Reply-To: <20031229183846.GI13481@actcom.co.il>
Message-ID: <Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
References: <20031229183846.GI13481@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Muli Ben-Yehuda wrote:
> 
> Summary of changes: 
> 
> - run the code through Lindent, and then fix it manually (this is the
> bulk of the patch) 

When doing things like this, can you split up the patches into two 
separate things: one that _only_ does whitespace changes, and that is 
guaranteed not to change anything else, and another that does the rest.

It's a total b*tch to try to figure out which change resulted in some 
difference, if the changes are intermixed with large whitespace cleanups.

		Linus

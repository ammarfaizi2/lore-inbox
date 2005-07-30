Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263118AbVG3Tiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbVG3Tiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbVG3Tiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:38:54 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:52519 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263118AbVG3Tiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:38:52 -0400
Date: Sat, 30 Jul 2005 21:40:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050730194053.GB19768@mars.ravnborg.org>
References: <20050730165202.GI5590@stusta.de> <20050730185226.GA9334@mars.ravnborg.org> <20050730185911.GA5481@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730185911.GA5481@infradead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 07:59:11PM +0100, Christoph Hellwig wrote:
> On Sat, Jul 30, 2005 at 08:52:26PM +0200, Sam Ravnborg wrote:
> > Please - use tabs for indention, not for alignment.
> > The below would look rather messy with tabs=4.
> > Almost everywhere tabs are used in Makefiles it is plina wrong.
> > Tabs are brillient for indention but you cannot just assume 8 spaces = a
> > tab. Not even at the beginning of the line.
> 
> as far as working on the kernel, yes you can assume that.

A bad assumption in several cases.
But if one never ever never use tabs != 8 they do not see the horror,
and so they probarly do not care.

For the Makefiles you will continue to see spaces used for alignmnet.

PS. Last word on this issue - I do not wan't to spend my linux time on a
sapce / versus tabs flamefest.

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbSIZVQk>; Thu, 26 Sep 2002 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbSIZVQk>; Thu, 26 Sep 2002 17:16:40 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:2820 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261529AbSIZVPr>; Thu, 26 Sep 2002 17:15:47 -0400
Date: Thu, 26 Sep 2002 22:20:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.38 - Config.in: Second extended fs rename / move Ext3 to a wiser place
Message-ID: <20020926222058.A604@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <200209261944.23447.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209261944.23447.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Thu, Sep 26, 2002 at 09:53:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 09:53:56PM +0200, Marc-Christian Petersen wrote:
> Hi there,
> 
> these are just cosmetic fixes.
> 
> I think we can do the following:
> 
> 1. rename: "Second extended fs support" to "Ext2 file system support"
>     (to be equal to Ext3fs)
> 
> 2. move: "Ext3 journalling file system support" near under to Ext2 fs.
> 
> Coments?

What's the point?

> I also thought about splitting the "Journal Filesystems" into an extra menu 
> option just to clear up the whole menu a bit since we have: ReiserFS, Ext3, 
> XFS, JFS, JFFS and JFFSv2. I cooked up a patch which does it, also attached!

The idea makes zero sense.  Blockbased filesystems sounds like more
useful split if the menu is really to big for you.


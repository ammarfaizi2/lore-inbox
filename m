Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVHVXIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVHVXIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHVXIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:08:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27140 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932282AbVHVXIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:08:01 -0400
Date: Tue, 23 Aug 2005 01:07:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       jffs-dev@axis.com
Subject: Re: use of uninitialized pointer in jffs_create()
Message-ID: <20050822230758.GL9927@stusta.de>
References: <9a87484905082015284c1686ec@mail.gmail.com> <20050822104559.GA11876@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050822104559.GA11876@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 12:45:59PM +0200, Jörn Engel wrote:
> On Sun, 21 August 2005 00:28:08 +0200, Jesper Juhl wrote:
> > 
> > gcc kindly pointed me at jffs_create() with this warning : 
> > 
> > fs/jffs/inode-v23.c:1279: warning: `inode' might be used uninitialized
> > in this function
> 
> Real fix would be to finally remove that code.  Except for the usual
> "change this function in the whole kernel" stuff, noone has touched it
> for ages.

That's wrong, this -mm specific bug comes git-ocfs2.patch .

> Jörn

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


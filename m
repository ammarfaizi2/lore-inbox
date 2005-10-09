Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVJIV3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVJIV3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 17:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVJIV3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 17:29:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42172 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932286AbVJIV3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 17:29:22 -0400
Date: Sun, 9 Oct 2005 22:29:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
Message-ID: <20051009212916.GM7992@ftp.linux.org.uk>
References: <20051009195850.27237.90873.stgit@zion.home.lan> <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org> <43497533.6090106@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43497533.6090106@utah-nac.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 01:53:23PM -0600, jmerkey wrote:
> Someone needs to fix fsck.ext3 while they are at it so it doesn't barf 
> when reading from reisferfs filesystems and return a command return of > 
> 2 during scanning of parttions during bootup. This looks like some sort 
> of anti-competitive crap and it doesn't belong in fsck.ext3 since 
> reiserfs is in the kernel.

Huh?  WTF are you trying to feed reiserfs to fsck.ext3 and just what do
you expect it to do?

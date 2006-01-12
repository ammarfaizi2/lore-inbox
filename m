Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWALFgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWALFgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWALFgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:36:10 -0500
Received: from cabal.ca ([134.117.69.58]:19168 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1030290AbWALFgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:36:09 -0500
Date: Thu, 12 Jan 2006 00:36:18 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: Junio C Hamano <junkio@cox.net>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Move read_mostly definition to asm/cache.h
Message-ID: <20060112053618.GH25353@tachyon.int.mcmartin.ca>
References: <20060111173321.GC28018@quicksilver.road.mcmartin.ca> <Pine.LNX.4.64.0601110951210.5073@g5.osdl.org> <7vslruqx5w.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vslruqx5w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 01:20:27PM -0800, Junio C Hamano wrote:
> Essentially, you are (you want to be) in read_mostly branch, but
> your .git/HEAD incorrectly says you are on the master branch.
> So you would need:
> 
> 	$ git symbolic-ref HEAD refs/heads/read_mostly
> 
> after swapping.  Then you would be on read_mostly branch.
>

Alternatively, if I had (I haven't touched the tree, just format-patch'd
which looked right) used git-reset --hard HEAD and been up to date
(working tree and index file) with whatever ended up being pointed
to by HEAD, right?

I'll try to remember the symbolic-ref thing for next time, usually when
this happens I just blow away the last commit and try again, but I felt
adventurous today. :)

Cheers,
	Kyle

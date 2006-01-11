Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWAKRwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWAKRwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWAKRwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:52:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932393AbWAKRwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:52:44 -0500
Date: Wed, 11 Jan 2006 09:52:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle McMartin <kyle@parisc-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move read_mostly definition to asm/cache.h
In-Reply-To: <20060111173321.GC28018@quicksilver.road.mcmartin.ca>
Message-ID: <Pine.LNX.4.64.0601110951210.5073@g5.osdl.org>
References: <20060111173321.GC28018@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Jan 2006, Kyle McMartin wrote:
> 
> I accidently committed this to an up-to-date master branch, as
> I forgot to check out the temporary branch I was going to commit
> it on. Swapping the sums from .git/refs/heads/{master,read_mostly}
> wouldn't break anything, if the only different between the two was
> this commit, right?

Correct. The branch head files really are just plain ascii references to 
the top commit, you can rename branches by just renaming the file (and 
thus switch branches by just cross-renaming them, ie just switching the 
contents).

		Linus

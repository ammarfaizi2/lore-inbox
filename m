Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311195AbSCLNhm>; Tue, 12 Mar 2002 08:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311197AbSCLNhX>; Tue, 12 Mar 2002 08:37:23 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:32407 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311195AbSCLNhV>;
	Tue, 12 Mar 2002 08:37:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Brian Gerst <bgerst@didntduck.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct superblock cleanup - minixfs
Date: Tue, 12 Mar 2002 14:32:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3C8D36D0.C43162A2@didntduck.org>
In-Reply-To: <3C8D36D0.C43162A2@didntduck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16kmOU-0001v7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 11, 2002 11:59 pm, Brian Gerst wrote:
> These two patches are the start of cleaning up the union of
> filesystem-specific structures in struct super_block.  The goal is to
> remove dependence on filesystem headers in fs.h.  The first patch
> abstracts the access to the minix_sb_info structure through the function
> minix_sb().  The second patch switches to using kmalloc to allocate the
> structure.

Nice to see it happening, even if it got there by a twisty path ;-)

-- 
Daniel

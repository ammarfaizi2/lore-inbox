Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSJ3KgY>; Wed, 30 Oct 2002 05:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264655AbSJ3KgY>; Wed, 30 Oct 2002 05:36:24 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:23965
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S264654AbSJ3KgX>; Wed, 30 Oct 2002 05:36:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Wed, 30 Oct 2002 05:42:47 -0500
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <200210300514.57193.dcinege@psychosis.com> <3DBFB362.2070506@pobox.com>
In-Reply-To: <3DBFB362.2070506@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300542.47207.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 5:24, Jeff Garzik wrote:

> You appear to be unaware of early userspace. Moving code out of the
> kernel does _not_ mean eliminating that code completely. 

My appologies, I thought you meant do_mounts.c was being yanked
entirly if initramfs goes in.

> do_mounts.c performs -- otherwise a Linux system would never have a root
> filesystem mounted.

Actually it's very possible to eliminate it....require an initramfs image
to have scripts and tools (mount and pivotroot) to do it all and mount that
as the root. (An interesting but pretty bad idea IMO) This is what I thought
you meant.

> Being unaware of early userspace implies that you are not familiar with
> initramfs.

I'll accept your apology after you see how nicely I cleaned up do_mounts.c
(It's 11K now) However I did not know the 'rootfs' was called 'early 
userspace'. (Or was my above assumption correct?)

> Which implies you wish you merge your own code in place of something you
> do not understand.

Jeff, be nice. I'm trying very hard myself...and if you knew me, you'd know
it's a difficult task. : >

Dave


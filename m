Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbTCRVJg>; Tue, 18 Mar 2003 16:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbTCRVJf>; Tue, 18 Mar 2003 16:09:35 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:23461 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262576AbTCRVJf>; Tue, 18 Mar 2003 16:09:35 -0500
Date: Tue, 18 Mar 2003 22:20:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Henrique Gobbi <henrique2.gobbi@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Building a 2.4.x kernel with all options
Message-ID: <20030318212029.GC6564@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.53.0303181346500.11080@skynet> <3E76FFB9.50908@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E76FFB9.50908@cyclades.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 March 2003 11:15:05 +0000, Henrique Gobbi wrote:
> 
> Is there a easy way to compile a linux 2.4 kernel with all possible 
> options. That is, something like "make all" or "make everything".
> 
> I need to build a kernel that has everything set. If possible I'd like 
> to use everything that can be module as module.'
> 
> Any hint is welcome

There is no easy way, there isn't even a single "biggest .config".
Some drivers are mutually exclusive, so you have to chose.

Tomorrow at work, I can send you a .config that should have almost
everything compiled into the kernel, for i386 uniprocessor, linux
2.4.21-pre3.

If you manage to create an even bigger .config from that base or have
other maxed our configs for smp, other platforms or other kernels, I'd
like to get a copy. But make sure they compile first. :)

Jörn

-- 
Correctness comes second.
Features come third.
Performance comes last.
Maintainability is needed for all of them.

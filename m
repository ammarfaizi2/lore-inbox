Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbTAJW6g>; Fri, 10 Jan 2003 17:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbTAJW6g>; Fri, 10 Jan 2003 17:58:36 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:20104 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266578AbTAJW6f>; Fri, 10 Jan 2003 17:58:35 -0500
Date: Sat, 11 Jan 2003 00:07:18 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Derek Atkins <warlord@MIT.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
Message-ID: <20030110230718.GO10062@louise.pinerecords.com>
References: <sjm7kdc63ul.fsf@kikki.mit.edu> <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [torvalds@transmeta.com]
> 
> I was hoping for a exact changset, your post didn't seem to be 100% sure.
> 
> Anyway, the one you pinpointed ("Make x86 platform choice strings more 
> easily selectable" top-of-tree is working), is followed by a patch by 
> Christop Hellwig ("Missed one 'try_inc_mod_count'") which almost certainly 
> isn't the cause of your trouble. So I'd like you to go forward a bit.
> 
> For example, if you know that your (2) happens before 2.5.54, then you can 
> do
> 
> 	bk clone -ql -rv2.5.54 linux-BK test-tree
> 	bk changes
> 	  .. look for the one you already know is ok: it's called 
> 	     "1.911.13.50" in the full 2.5.54 tree ..

Or you can just do everything "by hand" using these two together:
	http://linux.bkbits.net:8080/linux-2.5
	ftp://ftp.nl.linux.org/pub/linux/bk2patch/v2.5

-- 
Tomas Szepe <szepe@pinerecords.com>

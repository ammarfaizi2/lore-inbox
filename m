Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUEOCht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUEOCht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 22:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUEOCht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 22:37:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34547 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264623AbUEOChp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 22:37:45 -0400
Date: Fri, 14 May 2004 20:55:32 -0500 (EST)
Message-Id: <20040514.205532.07641094.wscott@bitmover.com>
To: elenstev@mesatop.com
Cc: adi@bitmover.com, scole@lanl.gov, support@bitmover.com, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page?
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <200405141854.33613.elenstev@mesatop.com>
References: <200405131723.15752.elenstev@mesatop.com>
	<20040514165311.GC6908@bitmover.com>
	<200405141854.33613.elenstev@mesatop.com>
X-Mailer: Mew version 4.0.64 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Cole <elenstev@mesatop.com>
> [steven@spc BK]$ ls -ls foo/RESYNC/SCCS/*
> 40048 -r--r--r--  1 steven steven 41007273 May 14 18:08 foo/RESYNC/SCCS/s.ChangeSet
>    68 -r--r--r--  1 steven steven    67791 May 14 18:11 foo/RESYNC/SCCS/s.CREDITS
>    76 -r--r--r--  1 steven steven    75264 May 14 18:11 foo/RESYNC/SCCS/s.MAINTAINERS
>   124 -r--r--r--  1 steven steven   124747 May 14 18:11 foo/RESYNC/SCCS/s.Makefile
>   
> Let me know if you want any of these files.  I can compress them and send them
> the usual way.

scan the ChangeSet file for nulls.

-Wayne

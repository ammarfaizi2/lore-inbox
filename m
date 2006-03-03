Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWCCAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWCCAUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWCCAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 19:20:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751842AbWCCAUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 19:20:13 -0500
Date: Thu, 2 Mar 2006 16:19:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Mahoney <jeffm@suse.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: [PATCH] reiserfs: reiserfs_file_write will lose error code when
 a 0-length write occurs w/ O_SYNC
In-Reply-To: <20060302153358.4cace15e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603021618400.22647@g5.osdl.org>
References: <20060302210947.GA16696@locomotive.unixthugs.org>
 <20060302153358.4cace15e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Mar 2006, Andrew Morton wrote:
>
> reiserfs-fix-unaligned-bitmap-usage.patch

I applied this one already, it seemed obvious.

(And then I've applied the ones you forwarded to me, of course).

		Linus

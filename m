Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTHGP3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHGP14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:27:56 -0400
Received: from angband.namesys.com ([212.16.7.85]:5815 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S270519AbTHGP1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:27:03 -0400
Date: Thu, 7 Aug 2003 19:27:01 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] reiserfs: fix locking in reiserfs_remount
Message-ID: <20030807152701.GJ20639@namesys.com>
References: <20030806093858.GF14457@namesys.com> <20030806172813.GB21290@matchmail.com> <20030806173114.GB15024@namesys.com> <3F32531B.7080000@namesys.com> <20030807133358.GC20639@namesys.com> <20030807082440.09b81626.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807082440.09b81626.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Aug 07, 2003 at 08:24:40AM -0700, Andrew Morton wrote:
> > I think it was Andrew. At least this new emergency remount path without
> > BKL was introduced by his patch without any extra attribution.
> Is that the only path?  It appears that way to me.
> The Locking document says that ->remoutn_fs is called under lock_kernel(),
> so this should be fixed at the VFS level.

Hm. Indeed.

Bye,
    Oleg

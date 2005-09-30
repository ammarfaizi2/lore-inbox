Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVI3FtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVI3FtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 01:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVI3FtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 01:49:09 -0400
Received: from silver.veritas.com ([143.127.12.111]:46414 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932419AbVI3FtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 01:49:08 -0400
Date: Fri, 30 Sep 2005 06:48:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 05/10] [PATCH]: Missing acct/mm calls in compat_do_execve()
In-Reply-To: <20050930022228.946664000@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0509300645530.7129@goblin.wat.veritas.com>
References: <20050930022016.640197000@localhost.localdomain>
 <20050930022228.946664000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Sep 2005 05:49:05.0733 (UTC) FILETIME=[AB1FB750:01C5C582]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Chris Wright wrote:

> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> As I do periodically, I checked to see how far out of sync
> compat_do_execve() has gotten from do_execve().  And as usual there
> was some missing stuff in the former.  Perhaps we need some tighter
> consolidation of these two routines to make this less likely to happen
> in the future.
> 
> Anyways, on the success path of compat_do_execve() we forget
> to call acct_update_integrals() and update_mem_hiwater(), as
> is done in do_execve().

The patch is good, but for -stable?  Spelling corrections next?

Hugh

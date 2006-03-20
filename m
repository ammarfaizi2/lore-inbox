Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWCTMLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWCTMLK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWCTMLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:11:10 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:14002 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932214AbWCTMLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:11:09 -0500
Date: Mon, 20 Mar 2006 05:11:07 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DoS with POSIX file locks?
Message-ID: <20060320121107.GE8980@parisc-linux.org>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 12:41:21PM +0100, Miklos Szeredi wrote:
> Unlike open files there doesn't seem to be any limit on the number of
> locks being held either globally or by a single process.

RLIMIT_LOCKS

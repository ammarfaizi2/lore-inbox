Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVDLGiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVDLGiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVDLGiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:38:01 -0400
Received: from waste.org ([216.27.176.166]:35787 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262016AbVDLGhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:37:54 -0400
Date: Mon, 11 Apr 2005 23:37:45 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steven French <sfrench@us.ibm.com>, Steve French <smfrench@austin.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cifs: md5 cleanup - functions
Message-ID: <20050412063745.GN25554@waste.org>
References: <Pine.LNX.4.62.0504112209220.2480@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504112209220.2480@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:11:39PM +0200, Jesper Juhl wrote:
> 
> Function names and return types on same line - conform to established 
> fs/cifs/ style.
> 
> Patch is also available at:
> 	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md5-funct.patch

I think the right thing to do here is what I did with the SHA1 code
from random.c: put the favorite implementation in lib/ and replace the
cryptoapi and CIFS implementations (and any other users) with it.

If you feel like tackling this, let me know, it's been on my todo list
for a while.

-- 
Mathematics is the supreme nostalgia of our time.

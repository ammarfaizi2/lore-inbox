Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVDCXOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVDCXOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVDCXOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:14:46 -0400
Received: from alpha.polcom.net ([217.79.151.115]:27872 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261953AbVDCXOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:14:45 -0400
Date: Mon, 4 Apr 2005 01:17:57 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Dag Arne Osvik <da@osvik.no>
Cc: Andreas Schwab <schwab@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
In-Reply-To: <425072A4.7080804@osvik.no>
Message-ID: <Pine.LNX.4.62.0504040109450.11173@alpha.polcom.net>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au>
 <424FE1D3.9010805@osvik.no> <jezmwgxa5v.fsf@sykes.suse.de> <425072A4.7080804@osvik.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Dag Arne Osvik wrote:
> (...) And, at least in 
> theory, long may even provide less than 32 bits.

Are you sure?

My copy of famous C book by B. W. Kernighan and D. Ritchie says that

sizeof(short) <= sizeof(int) <= sizeof(long)

and

sizeof(short) >= 16,
sizeof(int) >= 16,
sizeof(long) >= 32.

The book is about ANSI C not C99 but I think this is still valid.

Am I wrong?


Grzegorz Kulewski

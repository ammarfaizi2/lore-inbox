Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWEUJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWEUJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEUJKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:10:25 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:63094 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932323AbWEUJKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:10:24 -0400
Date: Sun, 21 May 2006 02:10:22 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Haar J?nos <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
Message-ID: <20060521091022.GA3468@taniwha.stupidest.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012201c67cb5$7a213800$1800a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 11:03:33AM +0200, Haar J?nos wrote:

> MemTotal:      2073048 kB
> MemFree:       1179376 kB

fine

> Buffers:        829764 kB

ok

> Cached:          19896 kB
> SwapCached:          0 kB
> Active:          15604 kB

> Inactive:       837636 kB

hrm

> HighTotal:     1179584 kB
> HighFree:      1154736 kB

krm

> LowTotal:       893464 kB
> LowFree:         24640 kB

bad

> SwapTotal:           0 kB
> SwapFree:            0 kB

ok

> Dirty:           21352 kB

ok

> Writeback:           0 kB
> Mapped:           7000 kB
> Slab:            22612 kB

ok




you have very little low


> Not installed.

urgh

> Wich package or where can i find the source? (i use redhat 9.0)

google i guess, i have very little idea how to drive RH to be honest

anyhow, it's not the slab


something is eating/using/leaking all your lowmemory


what kernel version is this?
how long has the machine been up?
do you see it get worse over time?



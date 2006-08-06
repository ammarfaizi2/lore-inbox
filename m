Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWHFTPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWHFTPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 15:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWHFTPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 15:15:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751564AbWHFTPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 15:15:41 -0400
Date: Sun, 6 Aug 2006 12:15:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: rusty@rustcorp.com.au, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
Message-Id: <20060806121530.eac1dd37.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 18:22:04 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> I was impressed by how fast 2.6.18-rc3-mm2 is under memory pressure,
> until I noticed that my "mem=512M" boot option was doing nothing.  The
> two fixes below got it working, but I wonder how many other early_param
> "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
> shows many such, i386 shows only one, I've not followed it up further.

Thanks again.

Andi, it sounds like so many fixes will be needed there that it's worth
dropping, pending rev #2.

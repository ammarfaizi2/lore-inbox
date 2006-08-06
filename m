Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWHFRcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWHFRcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 13:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWHFRcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 13:32:23 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:63436 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751081AbWHFRcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 13:32:22 -0400
Date: Sun, 6 Aug 2006 18:31:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
In-Reply-To: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0608061829430.20012@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Aug 2006 17:32:13.0593 (UTC) FILETIME=[411AC890:01C6B97E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006, Hugh Dickins wrote:
> I was impressed by how fast 2.6.18-rc3-mm2 is under memory pressure,
> until I noticed that my "mem=512M" boot option was doing nothing.  The
> two fixes below got it working, but I wonder how many other early_param
> "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
> shows many such, i386 shows only one, I've not followed it up further.

Oh, and that's not enough for it to show up in x86_64's /proc/cmdline.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S288490AbVBEFgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S288490AbVBEFgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 00:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S288494AbVBEFgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 00:36:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35994 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S288476AbVBEFgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 00:36:44 -0500
Date: Sat, 5 Feb 2005 05:36:40 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Michael Frank at BerliOS <mhf@hornet.berlios.de>
Cc: linux-kernel@vger.kernel.org, "Kernel Mailing List"@hornet.berlios.de
Subject: Re: [PATCH] 2.6.11-rc3 fix compile failure in arch/i386/kernel/i387.c
Message-ID: <20050205053640.GM8859@parcelfarce.linux.theplanet.co.uk>
References: <420459A2.nailH9511F7VV@hornet.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420459A2.nailH9511F7VV@hornet.berlios.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 06:29:06AM +0100, Michael Frank at BerliOS wrote:
> Using patch-2.6.11-rc3.bz2 from kernel.org on top of 2.6.10, 
> a compile failure in /arch/i386/kernel/i387.c due to tsk->used_math undef.
> 
> The patch log shows offsets but no rejects
> 
> patching file arch/i386/kernel/i387.c
> Hunk #6 succeeded at 538 (offset 15 lines).
> Hunk #7 succeeded at 553 (offset 15 lines).

No offsets (or compile problems) here.  Have you verified that your 2.6.10
had no local changes?

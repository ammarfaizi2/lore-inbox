Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWETQZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWETQZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 12:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWETQZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 12:25:18 -0400
Received: from main.gmane.org ([80.91.229.2]:49314 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751433AbWETQZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 12:25:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@gmail.com>
Subject: Re: 2.6.17-rc4-mm2
Date: Sat, 20 May 2006 18:24:57 +0200
Message-ID: <20060520182457.771dbd35@holly.localdomain>
References: <20060520054103.46a6edb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chaos.mk.cvut.cz
X-Newsreader: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2006 05:41:03 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm2/
> 
> 
> - Major rework in the libata (SATA) drivers.  If anyone has had any
> problem with the SATA drivers, please test this tree and report the
> results.  We expect it to fix quite a few things.
> 
> - reiser4 doesn't compile, due to changes to core pagecache APIs.
> The fix wasn't obvious.

It compiled after replacing generic_file_read with do_sync_read, but I
am a bit afraid of booting it :)

-- 
Jindrich Makovicka


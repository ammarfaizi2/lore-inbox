Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267557AbUHZErt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbUHZErt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUHZErt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:47:49 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:7292 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267557AbUHZEri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:47:38 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: jmerkey@comcast.net, linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
X-Message-Flag: Warning: May contain useful information
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
	<20040826043318.GO2793@holomorphy.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 25 Aug 2004 21:46:43 -0700
In-Reply-To: <20040826043318.GO2793@holomorphy.com> (William Lee Irwin,
 III's message of "Wed, 25 Aug 2004 21:33:18 -0700")
Message-ID: <52isb6bj64.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Aug 2004 04:46:43.0307 (UTC) FILETIME=[AF3AD3B0:01C48B27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    William> ELF ABI violation. "...the reserved area shall not
    William> consume more than 1GB of the address space."

Agreed, but I do like running with PAGE_OFFSET == 0xB0000000 on my
main box, which has 1 GB of RAM.  I can avoid highmem and still use
the last 128 MB of RAM.  It takes me about 3 seconds to edit
<asm/page.h> when I build a new kernel so I'm not arguing for merging
this, though.

 - R.

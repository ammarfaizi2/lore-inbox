Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUH3ScW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUH3ScW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUH3SbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:31:07 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:55837 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266069AbUH3SaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:30:09 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jmerkey@comcast.net, alan@lxorguk.ukuu.org.uk, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
X-Message-Flag: Warning: May contain useful information
References: <083020040556.26446.4132C1810009E19F0000674E2200751150970A059D0A0306@comcast.net>
	<20040830111019.5ddc99ab.rddunlap@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 30 Aug 2004 11:28:56 -0700
In-Reply-To: <20040830111019.5ddc99ab.rddunlap@osdl.org> (Randy Dunlap's
 message of "Mon, 30 Aug 2004 11:10:19 -0700")
Message-ID: <524qmk7a53.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Aug 2004 18:28:56.0958 (UTC) FILETIME=[360791E0:01C48EBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Randy> It doesn't barf on me.  I added one other patch on top of
    Randy> yours: one from Roland Dreier, for
    Randy> arch/i386/kernel/doublefault.c [below].

BTW, I can't imagine my patch would make any difference -- it only
affects what gets printed out right before the kernel locks up on a
double fault.

I am running a 2.6.8.1 kernel with PAGE_OFFSET set to 0xb000000 on my
desktop with USB mouse and keyboard (and 1 GB of RAM) with no problems.

 - R.

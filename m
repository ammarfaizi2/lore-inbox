Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVA2Fpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVA2Fpr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 00:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVA2Fpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 00:45:46 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:46636 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262858AbVA2Fpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 00:45:43 -0500
To: Christopher Li <chrisl@vmware.com>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       linux kernel mail list <linux-kernel@vger.kernel.org>
Subject: Re: compat ioctl for submiting URB
X-Message-Flag: Warning: May contain useful information
References: <20050128212304.GA11024@64m.dyndns.org>
	<1106972991.3972.57.camel@sherbert>
	<20050129013305.GA7792@64m.dyndns.org>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 28 Jan 2005 21:45:38 -0800
In-Reply-To: <20050129013305.GA7792@64m.dyndns.org> (Christopher Li's
 message of "Fri, 28 Jan 2005 20:33:05 -0500")
Message-ID: <52brb8vldp.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Jan 2005 05:45:41.0860 (UTC) FILETIME=[C4D02A40:01C505C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christopher> This patch is for the case that running 32 bit
    Christopher> application on a 64 bit kernel. So far only x86_64
    Christopher> allow you to do that.

Actually, at least ia64, mips, parisc, ppc64, s390 and sparc64 also
support 32-bit applications on a 64-bit kernel.  All of those
architectures except s390 can use USB.  I guess vmware doesn't run on
most of those architectures but any solution in the mainline kernel
should be generic enough to handle them all.

 - R.

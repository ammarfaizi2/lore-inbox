Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbUKOUbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUKOUbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUKOUbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:31:42 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:9503 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261676AbUKOUar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:30:47 -0500
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041113030203.GU2249@stusta.de>
	<20041115195148.GA12820@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 15 Nov 2004 12:30:38 -0800
In-Reply-To: <20041115195148.GA12820@kroah.com> (Greg KH's message of "Mon,
 15 Nov 2004 11:51:48 -0800")
Message-ID: <52brdyn9ch.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [2.6 patch] PCI cleanups
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 15 Nov 2004 20:30:43.0812 (UTC) FILETIME=[FB0FC240:01C4CB51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> These changes are for when drivers want to start taking
    Greg> advantage of some MSI features.  I've heard rumors that
    Greg> those drivers will be public soon, but haven't seen them yet :(

My Mellanox HCA driver -- subversion tree at

    https://openib.org/svn/gen2/trunk/src/linux-kernel/infiniband/hw/mthca

can use multiple MSI-X vectors with this kernel API.  I'll be
submitting it for upstream inclusion soon, so please don't remove the
kernel support.

Of course there isn't a yet stable device firmware release that
enables MSI-X ;(

Thanks,
 Roland

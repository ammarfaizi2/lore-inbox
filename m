Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVCDFLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVCDFLF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVCDFDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:03:31 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53793 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262145AbVCDElS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:41:18 -0500
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][10/10] verify_area cleanup : deprecate
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.62.0503040342510.2801@dragon.hygekrogen.localhost>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Mar 2005 20:41:14 -0800
In-Reply-To: <Pine.LNX.4.62.0503040342510.2801@dragon.hygekrogen.localhost> (Jesper
 Juhl's message of "Fri, 4 Mar 2005 03:49:38 +0100 (CET)")
Message-ID: <52is48m39x.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 04:41:14.0431 (UTC) FILETIME=[65B0D4F0:01C52074]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jesper> Eventually when this has been deprecated for a while I'll
    Jesper> send patches to completely remove the function (thoughts
    Jesper> on how long it should be deprecated first are welcome).

I don't have an opinion on how long to wait before removing the
function, but this patch should probably add an entry to
Documentation/feature-removal.txt.

 - R.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVBPVC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVBPVC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVBPVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:02:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:42005 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262019AbVBPVCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:02:47 -0500
To: "govind raj" <agovinda04@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
X-Message-Flag: Warning: May contain useful information
References: <BAY10-F2463631423ADD0786503EAD66C0@phx.gbl>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 16 Feb 2005 13:02:45 -0800
In-Reply-To: <BAY10-F2463631423ADD0786503EAD66C0@phx.gbl> (govind raj's
 message of "Thu, 17 Feb 2005 02:18:13 +0530")
Message-ID: <52zmy4w74a.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Feb 2005 21:02:46.0064 (UTC) FILETIME=[DD3AE300:01C5146A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    govid> Kernel panic - not syncing: Attempted to kill init!

It seems your kernel is booting fine, but your init process is exiting
(which leads to this message).  What userspace do you have installed
on your compact flash card?  In particular what are you using as "init"?

 - Roland

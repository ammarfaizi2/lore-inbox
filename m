Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbUKOEqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUKOEqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUKOEqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:46:36 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:5811 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261431AbUKOEqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 23:46:35 -0500
To: johnpol@2ka.mipt.ru
Cc: Jan Dittmer <jdittmer@ppp0.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <41974A6C.20302@ppp0.net>
	<20041114230617.5ce14ce9@zanzibar.2ka.mipt.ru>
	<4197BCEE.1080409@ppp0.net> <1100493835.20731.63.camel@uganda>
From: Roland Dreier <roland@topspin.com>
Date: Sun, 14 Nov 2004 20:46:27 -0800
In-Reply-To: <1100493835.20731.63.camel@uganda> (Evgeniy Polyakov's message
 of "Mon, 15 Nov 2004 07:43:55 +0300")
Message-ID: <52hdnrpvmk.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] matrox w1: fix integer to pointer conversion warnings
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 15 Nov 2004 04:46:33.0154 (UTC) FILETIME=[14A35A20:01C4CACE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Evgeniy> So there is no char __iomem, but only void __iomem.

Declaring a pointer as "char __iomem *" is a perfectly good thing to
do.  __iomem is a type attribute and can be added to just about any
base type.

 - Roland

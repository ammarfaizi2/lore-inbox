Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUEMNYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUEMNYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUEMNYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:24:47 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:1474 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264182AbUEMNYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:24:46 -0400
Subject: Re: [PATCH] AES i586 optimized
From: Christophe Saout <christophe@saout.de>
To: Fruhwirth Clemens <clemens-dated-1085310070.4b1f@endorphin.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040513110110.GA8491@ghanima.endorphin.org>
References: <20040513110110.GA8491@ghanima.endorphin.org>
Content-Type: text/plain
Message-Id: <1084454678.8393.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Thu, 13 May 2004 15:24:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 13.05.2004 um 13:01 Uhr +0200 schrieb Fruhwirth Clemens:

> The following patch adds an i586 optimized implementation of AES aka
> Rijndael.
> [...]

This patch breaks with regparm=3. With the patch (just a quick hack) at
http://www.saout.de/misc/aes-i586-regparm3.patch it works with regparm=3
(and only regparm=3).

There should be a better way.

The optimized AES is about twice as fast too on my Pentium M.



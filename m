Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVHLVgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVHLVgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVHLVgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:36:43 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34024 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751290AbVHLVgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:36:42 -0400
Subject: Re: [PATCH] cpm_uart: Fix spinlock initialization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Kumar Gala <galak@freescale.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuppc-embedded@freescale.com,
       vbordug@ru.mvista.com
In-Reply-To: <20050812204617.C21152@flint.arm.linux.org.uk>
References: <Pine.LNX.4.61.0508121132060.18385@nylon.am.freescale.net>
	 <20050812204617.C21152@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Aug 2005 23:03:05 +0100
Message-Id: <1123884186.22460.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-12 at 20:46 +0100, Russell King wrote:
> (Since Linus pulled the shutters down when I still had a large chunk
> of stuff in my serial tree, my serial patch merging is currently at
> a complete standstill.)

Well in the mean time for some more amusement see what you think of

http://zeniv.linux.org.uk/~alan/serial.diff

which is the current kmalloc based serial buffering patch.

Alan


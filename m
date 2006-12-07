Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031835AbWLGIQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031835AbWLGIQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031837AbWLGIQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:16:41 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60869
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1031835AbWLGIQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:16:40 -0500
Date: Thu, 07 Dec 2006 00:16:52 -0800 (PST)
Message-Id: <20061207.001652.18307358.davem@davemloft.net>
To: amit2030@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] net/wanrouter/wanmain.c: check kmalloc() return
 value.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061206230458.d11b2bb0.amit2030@gmail.com>
References: <20061206230458.d11b2bb0.amit2030@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Choudhary <amit2030@gmail.com>
Date: Wed, 6 Dec 2006 23:04:58 -0800

> Description: Check the return value of kmalloc() in function dbg_kmalloc(), in file net/wanrouter/wanmain.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>

Better to just delete this code altogether, there is no need
for any subsystem to duplicate the already implemented
SLAB debugging functionality.

And that's how I'll fix this, thanks for pointing out the
problem :)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVCBRnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVCBRnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVCBRml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:42:41 -0500
Received: from ns1.coraid.com ([65.14.39.133]:56308 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262372AbVCBRmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:42:32 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: [PATCH] aoe: fix printk warning (sparc64)
References: <20050301211754.5e968c2f.rddunlap@osdl.org>
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 02 Mar 2005 12:37:48 -0500
In-Reply-To: <20050301211754.5e968c2f.rddunlap@osdl.org> (Randy Dunlap's
 message of "Tue, 1 Mar 2005 21:17:54 -0800")
Message-ID: <87zmxmaqz7.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap writes:

> aoeblk: mac_addr() returns u64, coerce to unsigned long long to printk it:
> (sparc64 build warning)
> 
> drivers/block/aoe/aoeblk.c:245: warning: long long unsigned int format, u64 arg (arg 2)
> drivers/block/aoe/aoeblk.c:31: warning: long long unsigned int format, u64 arg (arg 4)
> 
> cross-compile results:
> https://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=4239

Thanks.  I have a few patches I'll be sending along soon (today, I
hope) in a batch, including Alexey Dobriyan's recent sparse cleanups,
and I'll include this one among them.

-- 
  Ed L Cashin <ecashin@coraid.com>


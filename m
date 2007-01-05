Return-Path: <linux-kernel-owner+w=401wt.eu-S1422703AbXAETvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbXAETvO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbXAETvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:51:14 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41174 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422703AbXAETvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:51:13 -0500
Date: Fri, 5 Jan 2007 20:51:24 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       kernel@bardioc.dyndns.org
Subject: Re: [PATCH] sysrq: showBlockedTasks is sysrq-X
Message-ID: <20070105195124.GA14720@aepfle.de>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net> <20070105193605.GA14592@aepfle.de> <20070105114111.879fbedc.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070105114111.879fbedc.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, Randy Dunlap wrote:

> OK.  There is also a collision on 'c':
> 
> drivers/net/ibm_emac/ibm_emac_debug.c:195:
>     return register_sysrq_key('c', &emac_sysrq_op)
> 
> and sysrq_crashdump_op.  I'd say ibm_emac needs to change too.

I have seen that too.
No idea if crashdump acutally works on ppc 4xx boards,
arch/powerpc/Kconfig lists CRASH_DUMP as ppc64 only.

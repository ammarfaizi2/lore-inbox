Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUA3S6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUA3S6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:58:40 -0500
Received: from devil.servak.biz ([209.124.81.2]:3016 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S262687AbUA3S6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:58:39 -0500
Subject: Re: 2.6.2-rc2-mm2
From: Torrey Hoffman <thoffman@arnor.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20040130014108.09c964fd.akpm@osdl.org>
References: <20040130014108.09c964fd.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1075489136.5995.30.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 30 Jan 2004 10:58:56 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-30 at 01:41, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm2/

I used the rc2-mm1-1 patch and got this on make modules_install:

WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/net/sunrpc/sunrpc.ko needs
unknown symbol groups_free
WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/fs/nfsd/nfsd.ko needs unknown
symbol sys_setgroups

Same .config had no problems in 2.6.2-rc2-mm1.

-- 
Torrey Hoffman <thoffman@arnor.net>


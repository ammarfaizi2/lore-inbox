Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268049AbTBWHOc>; Sun, 23 Feb 2003 02:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268050AbTBWHOc>; Sun, 23 Feb 2003 02:14:32 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:36858 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S268049AbTBWHOb>; Sun, 23 Feb 2003 02:14:31 -0500
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: Albert Cahalan <albert@users.sf.net>
To: "David S. Miller" <davem@redhat.com>
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org,
       rddunlap@osdl.org
In-Reply-To: <20030222.230008.08415849.davem@redhat.com>
References: <1045983722.32116.8.camel@cube> 
	<20030222.230008.08415849.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Feb 2003 02:20:56 -0500
Message-Id: <1045984856.32116.14.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 02:00, David S. Miller wrote:
>    From: Albert Cahalan <albert@users.sourceforge.net>
>    Date: 23 Feb 2003 02:02:01 -0500
>    
>    Casts are ugly and they hide bugs. There is a fix
>    for this problem: make u64 be "unsigned long long"
>    for every arch. That works for both 32-bit and 64-bit
>    systems. Likewise, choose "unsigned" for u32 even
>    if an "unsigned long" would work for a given arch.
>    
> That merely hides the lack of user defined printf types
> in gcc, it doesn't make the real problem go away.
> What you suggest is merely a bandaid.

Sure. It's an obviously useful bandaid that works
with gcc 2.91, 2.92, 2.95, 2.96, 3.0, 3.2, 3.3, etc.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267086AbSLRBGo>; Tue, 17 Dec 2002 20:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbSLRBGo>; Tue, 17 Dec 2002 20:06:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:59285 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267086AbSLRBGn>;
	Tue, 17 Dec 2002 20:06:43 -0500
Message-ID: <3DFFCBFC.FF3C221@digeo.com>
Date: Tue, 17 Dec 2002 17:14:36 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (v3) move LOG_BUF_SIZE to header/config
References: <3DFF5E67.C0BA874C@digeo.com> <Pine.LNX.4.33L2.0212171427520.17648-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 01:14:36.0408 (UTC) FILETIME=[D4886780:01C2A632]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Changes from yesterday:
> 
> a.  use a shift value (suggested by HCH); probably still not as quite
>     as free and open as he suggested, but I had user-friendliness
>     problems with that.
> 
> b.  allow a wider range of values (HCH and James Cloos):
>     smaller added, larger can be added as needed.
> 
> c.  put common config into kernel/Kconfig and include that in each
>     arch/*/Kconfig
> 
> More comments?
> 

Well I like it.  You were missing the arch/ia32/Kconfig include btw...

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbTAZXVt>; Sun, 26 Jan 2003 18:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTAZXVq>; Sun, 26 Jan 2003 18:21:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:59106 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267057AbTAZXVo>; Sun, 26 Jan 2003 18:21:44 -0500
Date: Mon, 27 Jan 2003 01:24:17 +0100
From: Christian Zander <zander@minion.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christian Zander <zander@minion.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127002417.GK394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030127000740.GJ394@kugai> <20030126231232.GE394@kugai> <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu> <30633.1043621749@passion.cambridge.redhat.com> <31172.1043622971@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31172.1043622971@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 11:16:11PM +0000, David Woodhouse wrote:
> 
> There are some differences, but nothing insurmountable.
> 
> For <=2.4 you have to include Rules.make at the end of your own
> Makefile, and for 2.5 that file doesn't exist any more. 
> 
> For older kernels you must set O_TARGET, for 2.5 I think the mere
> act of setting it causes the build to break -- that one is
> gratuitously making it harder to make external modules which compile
> in both and I've complained about it before.
> 
> Per-file CFLAGS must have a full path specified now in 2.5, whereas
> in 2.4 and earlier it was just 'CFLAGS_filename.o'.
> 

Thanks for pointing that out, I'll look into this more closely. If it
is as simple as you say, I'll be inclined to share your sentiment
towards custom build systems interfacing with the Linux kernel.

-- 
christian zander
zander@minion.de

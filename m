Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261753AbSIXS5a>; Tue, 24 Sep 2002 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSIXS5a>; Tue, 24 Sep 2002 14:57:30 -0400
Received: from outboundx.mv.meer.net ([209.157.152.12]:36875 "EHLO
	outboundx.mv.meer.net") by vger.kernel.org with ESMTP
	id <S261753AbSIXS53>; Tue, 24 Sep 2002 14:57:29 -0400
Message-ID: <3D90B6CA.5099FE6A@jwz.org>
Date: Tue, 24 Sep 2002 12:02:34 -0700
From: Jamie Zawinski <jwz@jwz.org>
Organization: my own bad self
X-Mailer: Mozilla 3.02 (X11; N; Linux 2.4.9-13smp i686)
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel oops, 2.4.19
References: <Pine.LNX.4.44.0209231210250.922-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Your kernel seems to be tainted. Are you using any binary-only module?

No, turns out that's from the ipchains that comes with the kernel:

Warning: loading /lib/modules/2.4.19/kernel/net/ipv4/netfilter/ipchains.o will taint the kernel: non-GPL license - BSD without advertisement clause

-- 
Jamie Zawinski
jwz@jwz.org             http://www.jwz.org/
jwz@dnalounge.com       http://www.dnalounge.com/

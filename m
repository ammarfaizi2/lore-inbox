Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSHJUGd>; Sat, 10 Aug 2002 16:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSHJUGd>; Sat, 10 Aug 2002 16:06:33 -0400
Received: from daimi.au.dk ([130.225.16.1]:57220 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317312AbSHJUGd>;
	Sat, 10 Aug 2002 16:06:33 -0400
Message-ID: <3D557326.CBD0E21E@daimi.au.dk>
Date: Sat, 10 Aug 2002 22:10:14 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stas Sergeev <stssppnn@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] vm86 bugs in 2.5.30
References: <3D556EF1.5010708@yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> 
> Hello.
> 
> Kasper Dupont wrote:
> > <4> invalid operand: 0000
> > <4>Code: Bad EIP value.
> > It happens during the vm86 system call, but it is not fixed
> > by any of the changes in vm86.c. Who remember which patch
> > fixed this problem?
> This one:
> http://dosemu.sourceforge.net/stas/traps.diff
> Was not included in 2.4.19, exists only in -ac
> for now.

Thanks. I'm actually using -ac kernels. The reason I missed
this patch was that the change was in another file. Tomorrow
I'll try this against 2.5.30.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk

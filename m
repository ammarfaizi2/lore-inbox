Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317977AbSHLNGv>; Mon, 12 Aug 2002 09:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSHLNGo>; Mon, 12 Aug 2002 09:06:44 -0400
Received: from daimi.au.dk ([130.225.16.1]:23495 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317977AbSHLNGn>;
	Mon, 12 Aug 2002 09:06:43 -0400
Message-ID: <3D57B3AC.3BCF36F8@daimi.au.dk>
Date: Mon, 12 Aug 2002 15:10:04 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       julliard@winehq.com, ldb@ldb.ods.org
Subject: Re: [patch] tls-2.5.31-C3
References: <20020812173404.39d3abab.sfr@canb.auug.org.au>
		<Pine.LNX.4.44.0208121205170.2561-100000@localhost.localdomain> 
		<20020812182325.52324305.sfr@canb.auug.org.au> <1029146896.16216.113.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> For that
> matter on Windows emulation I thought Windows also needed 0x40 to be the
> same offset as the BIOS does so can't we leave it hardwired ?

Does Wine and the BIOS actually want the same? I would believe there
would have to be a small difference. Having Wine and BIOS using the
same memory doesn't sound right to me.

Wine wanting segment 0x40 to point to virtual address 0x400 and BIOS
wanting segment 0x40 to point to physical address 0x400 sounds more
reasonable to me. But physical address 0x400 would be virtual address
0xC0000400 with the default PAGE_OFFSET.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk

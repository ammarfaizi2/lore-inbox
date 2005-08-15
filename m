Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVHOQk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVHOQk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVHOQk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:40:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60324 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964836AbVHOQk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:40:27 -0400
Date: Mon, 15 Aug 2005 17:40:23 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jim Ramsay <jim.ramsay@gmail.com>
cc: yhlu <yhlu.kernel@gmail.com>,
       =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>,
       alex.kern@gmx.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atyfb questions and issues
In-Reply-To: <4789af9e050815092545fe2925@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0508151733160.7300@pentafluge.infradead.org>
References: <4789af9e050812101110d3642d@mail.gmail.com> 
 <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl> 
 <86802c4405081211021e76349c@mail.gmail.com> <4789af9e050815092545fe2925@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I wonder if James put that in mainstream, he already sent one patch
> > for 2.6.5....
> > 
> > please refer to
> > http://www.linuxbios.org/pipermail/linuxbios/2004-May/007734.html
> 
> It appears to me that this patch is in the 2.6.11 from linux-mips.org
> that I am presently using.

Its in the standard tree as well. The question is does it work in the mips 
branch? Last time I tried booting without the bios it did not work. Yhlu 
is right, atyfb_setup_generic is called which in x86 calls the 
init_from_bios function. Then in aty_init is the biosless initializing is 
done. 

> Maybe his mips FW does this, but mine doesn't.  Any tips on how I can
> do this in software?

The idea of the patch is not to need FW.

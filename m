Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTIOVMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTIOVMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:12:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:18369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbTIOVMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:12:30 -0400
Date: Mon, 15 Sep 2003 14:12:26 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: Cort Dougan <cort@ftsoj.fsmlabs.com>
cc: <linux-kernel@vger.kernel.org>, <plm-devel@lists.sourceforge.net>
Subject: Re: PowerPC Cross-compile of 2.6 kernels
In-Reply-To: <20030913005537.GA767@ftsoj.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0309151318010.631-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Cort Dougan wrote:

> It would be nice to see the 4xx and 8xx chips being tested.  There are a
> lot of rarely tested configurations and targets in the PPC kernel.

I could run a simpler compile filter, one compile that counts and
prints all the errors and warnings, on these extra platforms.  Did you
have any specific platform in mind?  40x give me 'walnut' and 8xx gives
me 'rpx-lite' if I do 'make defconfig' followed by 'make oldconfig' where
I set the main platform (to 40x or 8xx) and accept all the default
options.

Judith


>
> } > > > > > In response to requests at OLS, we've added cross-compile
> } > > > > > capability to the PLM, and the first architecture
> } > > > > > implemented is PowerPC.  The powerpc code is
> } > > > > > generated via a cross-compiler set up using Dan
> } > > > > > Kegels's crosstool-0.22 on an i386 host using gcc-3.3.1,
> } > > > > > glibc-2.3.2 and built for the powerpc-750.
> } > > > > >
> } > > > > > The filter run is the compile regress developed by John
> } > > > > > Cherry at OSDL.  Refer to his prior mail on lkml for the
> } > > > > > results of this filter on ia386 and IA64.
> } > > > > >
> } > > > > > Look at
> } > > > > >     http://www.osdl.org/plm-cgi/plm?module=search
> } > > > > > and look up linux-2.6.0-test5 or any later kernels for the
> } > > > > > results of this filter under 'PPC-Cross Compile Regress'.
> } > > > > >
> } > > > > > Does anyone have any input regarding requests for
> } > > > > > additional architectures or improvements to the
> } > > > > > filters?  Please cc me in any responses to lkml as I do
> } > > > > > not currently monitor this list, though other OSDL
> } > > > > > employees do.
>



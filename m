Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbUAYRNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbUAYRNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:13:42 -0500
Received: from [213.92.5.19] ([213.92.5.19]:23259 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S264557AbUAYRNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:13:41 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Sun, 25 Jan 2004 18:11:27 +0100
User-Agent: KMail/1.6
Cc: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de>
In-Reply-To: <20040125162122.GJ513@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401251811.27890.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Sunday 25 January 2004 17:21, Adrian Bunk ha scritto:

>
> What's your gcc version ("gcc --version")?

gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)


>
> Could you back out ("patch -p1 -R < ..." or manually remove the lines)
> the patch below and retry?

Yep, and now it works :)
Now I'm running  2.6.1-mm4, tested both UP and SMP (SMT) and it boots just 
fine. Later I'll try with more recents releases, but I'm pretty sure that 
these will work.

Many thanks, the patch has solved this issue :)
-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

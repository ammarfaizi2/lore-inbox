Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUAZOvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUAZOvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:51:18 -0500
Received: from relay.dada.it ([195.110.100.8]:52302 "EHLO ironport.dada.it")
	by vger.kernel.org with ESMTP id S264893AbUAZOvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:51:13 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: "John Stoffel" <stoffel@lucent.com>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Mon, 26 Jan 2004 15:51:02 +0100
User-Agent: KMail/1.6
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, eric@cisu.net,
       linux-kernel@vger.kernel.org
References: <20040125162122.GJ513@fs.tum.de> <20040126060952.GC6519@colin2.muc.de> <16405.8292.823683.530462@gargle.gargle.HOWL>
In-Reply-To: <16405.8292.823683.530462@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401261551.02757.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Monday 26 January 2004 15:12, John Stoffel ha scritto:

>
> Just to follow up here.  On kernels 2.6.2-rc1 and 2.6.2-rc2, it just
> hangs on bootup and doesn't give any Oops output.
>
> When I tried out 2.6.2-rc1-mm[1,2,3], it would start booting, but
> oops immediately with the one I posted before, but I've re-created
> here.

It seems a little bit different from my situation: 2.6.2-rcX (basically non 
-mm versions) boots and works just fine (besides some oopses on shutdown, but 
this is another story, I'll investigate further on this).
-mm series, both 2.6.2-rcX-mmY and 2.6.1-mmZ with Z > 3 hangs after 
decompressing image, if I leave -funit-at-time in Makefile. I can  redo any 
of these tests, I can also use a serial interface to capture any "hidden" 
oops, if someone sends me any needed patch to show some data (i.e. early 
printk) and the desired tests.

>
> I'm at work now, so I won't be able to do any tests besides remote
> kernel compiles during the day.

The same holds for me :)

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.


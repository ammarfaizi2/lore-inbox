Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWFQXEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWFQXEn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWFQXEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 19:04:43 -0400
Received: from aun.it.uu.se ([130.238.12.36]:49894 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750987AbWFQXEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 19:04:43 -0400
Date: Sun, 18 Jun 2006 01:04:38 +0200 (MEST)
Message-Id: <200606172304.k5HN4cnF004470@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: w@1wt.eu
Subject: Re: [patch 2.4.33-rc1] updated patch kit for gcc-4.1.1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 23:38:24 +0200, Willy Tarreau wrote:
>On Sat, Jun 17, 2006 at 10:52:05PM +0200, Mikael Pettersson wrote:
>> An updated patch kit allowing gcc-4.1.1 to compile the 2.4.33-rc1 kernel is now available:
>> <http://user.it.uu.se/~mikpe/linux/patches/2.4/patch-gcc4-fixes-v15-2.4.33-rc1>
>> 
>> Changes since the previously announced version of the patch kit
>> <http://marc.theaimsgroup.com/?l=linux-kernel&m=114149697417107&w=2>:
>> 
>> - Merged the fixes for gcc-4.1 into the baseline patch kit for gcc-4.0.
>> - I previously reported that gcc-4.1.0 built ppc32 kernels that oopsed
>>   in shrink_dcache_parent(). gcc-4.1.1 fixed this issue.
>> - The architectures known to work in kernel 2.4.33-rc1 + this patch kit
>>   with gcc-4.1.1 and gcc-4.0.3 are i386, x86-64, and ppc32.
>
>Thanks for still maintaining this patchset. I sometimes have coworkers
>complain that they cannot build 2.4 anymore because they have let their
>distro automatically upgarde gcc to 4.x. I will be able to point your
>site to them. I was also thinking about updating my page on "linux
>kernel useful patches" with this last update, but noticed you still have
>a "patch-more-gcc4-fixes" file. Is it absolutely needed or just a cleanup ?

`patch-gcc4-fixes-v15-2.4.33-rc1' contains all required core patches,
and all patches for the drivers etc I use. I don't need any other
patch on any of my i386/x86-64/ppc32 machines.

`patch-more-gcc4-fixes' contains compile-time fixes for all drivers etc
I was able to select when doing the initial gcc-4.0 work, except for
those drivers I actually use (they are in the core patch set). I can't
test these drivers, but I keep the patches around just in case they ever
become useful.

/Mikael

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWIWL3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWIWL3g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWIWL3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:29:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:4847 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750734AbWIWL3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:29:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Sat, 23 Sep 2006 13:29:21 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609231303.35481.arnd@arndb.de> <8bd0f97a0609230415v6a31a784kf6a381f274cf7ef6@mail.gmail.com>
In-Reply-To: <8bd0f97a0609230415v6a31a784kf6a381f274cf7ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609231329.22251.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 13:15, Mike Frysinger wrote:
> then that would not be just anomaly.h, that would be the entire mach
> header subdirs:
> include/asm-blackfin/mach-bf533/
> include/asm-blackfin/mach-bf535/
> include/asm-blackfin/mach-bf537/
> include/asm-blackfin/mach-bf561/
> 
> relocated to the dirs:
> arch/blackfin/mach-bf533/
> arch/blackfin/mach-bf535/
> arch/blackfin/mach-bf537/
> arch/blackfin/mach-bf561/

Right, that sounds good. Of course it doesn't make sense for files that
are used outside of arch/blackfin/mach-bfXXX/, but if your split between
platform specific and generic files is good, you don't have that problem.

	Arnd <><

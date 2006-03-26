Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWCZSlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWCZSlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCZSlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:41:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41157 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751071AbWCZSlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:41:24 -0500
Date: Sun, 26 Mar 2006 20:40:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: jzb@aexorsyst.com, linux-kernel@vger.kernel.org
Subject: Re: mem= causes oops
In-Reply-To: <20060326094121.9464762a.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0603262040090.28657@yvahk01.tjqt.qr>
References: <200603212005.58274.jzb@aexorsyst.com> <200603240936.13178.jzb@aexorsyst.com>
 <20060324163237.5743bd3c.rdunlap@xenotime.net> <200603251036.40379.jzb@aexorsyst.com>
 <Pine.LNX.4.61.0603251948360.29793@yvahk01.tjqt.qr>
 <20060326094121.9464762a.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Hm, seeing this mail reminds me of something I seen on SPARC just a while 
>> ago. Maybe it's just something on my side. If I specify `mem=65536`, that 
>> is, with no size suffix like M or G, what does Linux make out of it? 65536 
>> KB or 64 KB?
>
>65536 bytes.  All of the suffixes [KMG] are optional.
>
Oh ok, that should explain why it 'segfaults' with mem=65536 ;)


Jan Engelhardt
-- 

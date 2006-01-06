Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWAFTO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWAFTO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWAFTO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:14:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54504 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932242AbWAFTO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:14:56 -0500
Date: Fri, 6 Jan 2006 20:14:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
In-Reply-To: <9a8748490601061026t3e467dfdxc90b6403bbd45802@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601062013130.28630@yvahk01.tjqt.qr>
References: <20060106173547.GR12131@stusta.de> 
 <9a8748490601060949g4765a4dcrfab4adab4224b5ad@mail.gmail.com> 
 <20060106180626.GV12131@stusta.de> <9a8748490601061026t3e467dfdxc90b6403bbd45802@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And when do you really need it?
>>
>Hmm, when I'm looking for broken stuff to fix ;)
>I guess you are right, ordinary users don't need it.. Ok, count me in
>as supporting this move.
>
I go with it.

I had CONFIG_BROKEN on, which 'cost' me one post to LKML to find out that
CONFIG_MTD_AMD... does rightfully not compile. It (CONFIG_BROKEN/CLEAN_COMPILE)
just confuses.


Jan Engelhardt
-- 

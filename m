Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbUL0Tw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUL0Tw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUL0Tvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:51:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35748 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261957AbUL0Tuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:50:52 -0500
Date: Mon, 27 Dec 2004 20:50:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot compile without sysctl (+semi-patch)
In-Reply-To: <20041227174319.GC5345@stusta.de>
Message-ID: <Pine.LNX.4.61.0412272040070.9354@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0412271803300.10322@yvahk01.tjqt.qr>
 <20041227174319.GC5345@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Preferably:
>> include/linux/limits.h:
>> #ifdef __KERNEL__
>> extern int ngroups_max;
>> # define NGROUPS_MAX ngroups_max
>> #else
>> # define NGROUPS_MAX __NGROUPS_MAX
>> #endif
>> 
>
>you should also tell us which kernel version you observed this problem 
>in - neither the latest 2.4 nor the latest 2.6 kernels have a limits.h 
>like the one you describe...

You'd spank me if I told you... :) SUSE KOTD 2004.12.02
That's a 2.6.8 + 2.6.9-rc2, plus a thousand patches.
Yeah, looks like it is kotd specific, never mind.
(patches.suse.tar.bz2#patches.suse/ngroups-max-var)


Jan Engelhardt
-- 
ENOSPC

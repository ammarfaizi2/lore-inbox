Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWCTVFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWCTVFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWCTVFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:05:08 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40836 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030275AbWCTVFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:05:06 -0500
Date: Mon, 20 Mar 2006 22:04:46 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: DervishD <lkml@dervishd.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, patrakov@ums.usu.ru
Subject: Re: [PATCH] Fix console utf8 composing (F)
In-Reply-To: <20060320200548.GB1627@DervishD>
Message-ID: <Pine.LNX.4.61.0603202200030.23653@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
 <20060320200548.GB1627@DervishD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Jan Engelhardt <jengelh@linux01.gwdg.de> dixit:
>> can we have the patch[2] from this[1] thread merged? I have not yet
>> heard back from Alexander since [3]. Plus we're lacking a
>> Signed-off-by so far for [2]. What to do?
>
>    Can it be backported to 2.4.x or does it use many 2.6.xisms? I'm
>very interested in the issue because otherwise I'm going to add a
>terminal emulator for virtual consoles to my vcinit project. I don't
>use X and I want to use utf8 in a virtual console...
>

Maybe. I just found that it does not apply cleanly anymore to 2.6.16 so I 
am going to fix that first and submit a rediffed version.
If I then feel like investing more time, maybe I can do it for 2.4.32 too, 
but no promises. I am running out of gcc3 systems.


Jan Engelhardt
-- 

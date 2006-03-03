Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWCCNbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWCCNbt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWCCNbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:31:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40845 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751302AbWCCNbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:31:48 -0500
Date: Fri, 3 Mar 2006 14:31:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: make IPV4 modular (was: [2.6 patch] make UNIX a bool)
In-Reply-To: <20060302223218.GN9295@stusta.de>
Message-ID: <Pine.LNX.4.61.0603031430280.2581@yvahk01.tjqt.qr>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au>
 <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
 <20060302203245.GD9295@stusta.de> <9a8748490603021240t31f58ea4ycafae4ee8a12095c@mail.gmail.com>
 <20060302214055.GH9295@stusta.de> <Pine.LNX.4.61.0603022251270.13101@yvahk01.tjqt.qr>
 <20060302223218.GN9295@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well, not directly topic'ed to CONFIG_UNIX, but if the IPv4 stack was modular
>> (like IPv6), we'd probably gain some 100 KB and would not have to worry about
>> CONFIG_UNIX for a while.
>
>I doubt making the IPv4 stack modular is worth the trouble, but feel 
>free to send a patch as a basis for a discussion...
>
It would possibly require EXPORT_SYMBOLs, which you seem to be opposed to...


Jan Engelhardt
-- 

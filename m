Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUGWMfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUGWMfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 08:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUGWMfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 08:35:06 -0400
Received: from webbox24.server-home.net ([195.137.212.20]:63968 "EHLO
	webbox24.server-home.net") by vger.kernel.org with ESMTP
	id S267678AbUGWMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 08:35:00 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
From: Walter Hofmann <lkml-040723143345-5954@secretlab.mine.nu>
Subject: Re: [PATCH] Delete cryptoloop
In-Reply-To: <2kECW-3a0-7@gated-at.bofh.it>
References: <2kvT4-5AY-1@gated-at.bofh.it> <2kC85-1AH-11@gated-at.bofh.it> <2kDxa-2sB-1@gated-at.bofh.it> <2kECW-3a0-7@gated-at.bofh.it>
Date: Fri, 23 Jul 2004 14:34:58 +0200
Message-Id: <E1BnzGM-0005zX-00@gimli.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote on linux.kernel:
> dpf-lkml@fountainbay.com wrote:
>>
>> Hopefully someone else will follow up, but I hope I'm somewhat convincing:
>
> Not really ;)
>
> Your points can be simplified to "I don't use cryptoloop, but someone else
> might" and "we shouldn't do this in a stable kernel".
>
> Well, I want to hear from "someone else".  If removing cryptoloop will
> irritate five people, well, sorry.  If it's 5,000 people, well maybe not.

I use cryptoloop and I would be really annoyed if it disappeared in
the stable kernel series. Besides, I read in another mail in this thread 
that dm-crypt will not work with file-based storage (I'm using 
cryptoloop on a file), and that it is new and potentially buggy.

I'm really surprised that people here argue that dm-crypt doesn't get 
enough testing so cryptoloop has to go to force people to test dm-crypt 
with their valuable data. This is all upside-down. First dm-crypt has to 
be stable, safe and feature-complete, then people can convert their data 
to dm-crypt and only then can cryptoloop be deleted.

Walter

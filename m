Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUI3Qmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUI3Qmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269342AbUI3Qmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:42:54 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:53893 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269337AbUI3Qmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:42:52 -0400
Message-ID: <415C37D8.20203@t-online.de>
Date: Thu, 30 Sep 2004 18:44:08 +0200
From: franz_pletz@t-online.de (Franz Pletz)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Rokos <michal@rokos.info>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
References: <200409230958.31758.michal@rokos.info> <200409231618.56861.michal@rokos.info>
In-Reply-To: <200409231618.56861.michal@rokos.info>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rCYyuEZGweMNH-BRrACxJEqpCwqyD0F1PBQj+T9f3xvozzmWRuxfca
X-TOI-MSGID: 5813d51e-b0af-40d5-bd81-4e3436c0bf20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Rokos wrote:
> On Thursday 23 of September 2004 09:58, you wrote:
> 
>>natsemi driver emits a lot of warnings.
>>This patch make compilation calm again.
>>Code taken from drivers/net/pci-skeleton.c. Thanks Jeff.
> 
> 
> This patch unfortunately makes natsemi stop working... :(
> 
> Sorry for sending bad patch - I've been testing it, but loaded the other 
> module.

It seems like your patch unfortunately went into 2.6.9-rc2-mm[3,4] and 
2.6.9-rc3.

My Natsemi network card stops working with 2.6.9-rc3. After succesfully 
revoking your patch from 
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/broken-out/natsemi-remove-compilation-warnings.patch
everything works fine.

Andrew and Linus, please revoke that one in mainline and mm.
Thanks.

Franz

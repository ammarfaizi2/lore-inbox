Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVCQCAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVCQCAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVCQCAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:00:22 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:43684 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262960AbVCQCAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:00:16 -0500
Message-ID: <4238E4B0.40703@g-house.de>
Date: Thu, 17 Mar 2005 03:00:16 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de>	<2cd57c9005031102595dfe78e6@mail.gmail.com>	<4231B4E9.3080005@g-house.de>	<42332F9C.7090703@g-house.de>	<4238DD01.9060500@g-house.de> <20050316175109.3c160d4d.akpm@osdl.org>
In-Reply-To: <20050316175109.3c160d4d.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Some application went berzerk, used up all the swap and then oomed the box.
> 
> You could perhaps run `top -d1' then hit M so the output is sorted by
> bloatiness, then try to catch the culprit.

i've already done that. as OOM happens when i am not around, i did that
with "ps":

http://lkml.org/lkml/2005/3/12/88
http://nerdbynature.de/bits/sheep/2.6.11/oom/daily_stats-2.6.11-rc5-bk2.log.gz

> But it would be better to have some app which prints the N most
> memory-hungry processes every second and simply scrolls that up the screen. 
> I'm not aware of such a thing, but it could be cooked up via
> /proc/N/cmdline and /proc/N/statm.

i hope the link above does reveal this information.

i just wrote a bug report for the (debian), ppp package, but to know
*where* the memory goes to would really help, i think.

thank you,
Christian.
-- 
BOFH excuse #72:

Satan did it

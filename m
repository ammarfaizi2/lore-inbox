Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWAKNVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWAKNVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWAKNVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:21:32 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:28026 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S1751493AbWAKNVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:21:31 -0500
In-Reply-To: <17348.58532.375242.210475@alkaid.it.uu.se>
References: <20060110205709.GE3911@stusta.de> <52078AC1-B781-4664-A03A-1DC84C84490B@neostrada.pl> <17348.58532.375242.210475@alkaid.it.uu.se>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6ACF03DE-0670-47BF-A97C-B4C4377E0647@neostrada.pl>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: [2.6 patch] ftape: remove some outdated information from Kconfig files
Date: Wed, 11 Jan 2006 14:20:47 +0100
To: Mikael Pettersson <mikpe@csd.uu.se>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-11, at 11:57, Mikael Pettersson wrote:

> Marcin Dalecki writes:
>>
>> On 2006-01-10, at 21:57, Adrian Bunk wrote:
>>
>>> This patch removes some outdated information about the ftape driver
>>> like
>>> pointers to no longer existing webpages from Kconfig files.
>>
>> You could just remove this driver completely as well. Because
>> practically since
>> it's inclusion in to the main stream kernel it has been outdated and
>> nonfunctioning.
>
> There exists configurations for which it does work.
>
>> 4. Right now the corresponding user space tools can't be found on the
>> web any longer.
>
> The only required tools are standard things like mt and tar or cpio.
> The tape formatting tools are out in the wild somewhere, big deal.

There are definitively no tape formatting tools for the in-kernel  
version.
Formatting was only supported by the external driver ever.
And this brings your former statement about some supposedly working  
configurations
in to question.

> Or are you volunteering to take over maintenance of ftape-4.x and  
> merge
> that into the kernel?

No. Tough I have been messing with the ftape driver a *long* time ago  
and
still have two QIC drives in the dust bin - I'm considering this kind
of hardware obsolete by a large margin.

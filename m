Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVIMTSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVIMTSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVIMTSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:18:00 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:13534 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S965158AbVIMTR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:17:59 -0400
Message-ID: <432725E3.70304@compro.net>
Date: Tue, 13 Sep 2005 15:17:55 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com> <4326DB8A.7040109@compro.net> <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de> <4326EAD7.50004@compro.net> <Pine.LNX.4.53.0509131750580.15000@gockel.physik3.uni-rostock.de> <43270294.9010509@compro.net> <43271CA3.7050706@stesmi.com>
In-Reply-To: <43271CA3.7050706@stesmi.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.13.18
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> Mark Hounschell wrote:
>>>Tim Schmielau wrote:
>>>
>>>>Do you also want to know about CONFIG_PREEMPT, SMP, current load, future
>>>>load in order to estimate the delay you want to ask for?
>>>
>>>Are not CONFIG_PREEMPT, SMP, and current load, all determinable from
>>>userland anyway? Why not HZ?
> 
> And with dynamic HZ?
> 
> Do you want
> a) The HZ that was used when we booted
> b) The HZ that is currently used (say 22, but could be 573 in 0.1s)
> c) The MIN HZ (if there is such a thing and it is configured)
>    that the kernel will use.
> d) The MAX HZ (same) that the kernel will use.
> 
> Or do you want USER_HZ?
> 
> Or are you after something else entirely.
> 
> // Stefan

If dynamic HZ means dynamic timer resolutions I don't want it at all.

I guess the 'terms' John just used, ie timer resolutions, as opposed to
HZ was maybe what I really should have asked for to begin with.

However since they are both bascially the same or at least one derived
from the other......?

Thanks
Mark

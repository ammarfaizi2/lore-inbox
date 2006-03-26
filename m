Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWCZQgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWCZQgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWCZQgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:36:50 -0500
Received: from [84.204.75.166] ([84.204.75.166]:34707 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1751399AbWCZQgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:36:50 -0500
Message-ID: <4426C320.9010002@yandex.ru>
Date: Sun, 26 Mar 2006 20:36:48 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: linux@horizon.com
Cc: kalin@thinrope.net, linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <20060326162100.9204.qmail@science.horizon.com>
In-Reply-To: <20060326162100.9204.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
> Sorry, I don't have anything in particular, just bits I've picked up
> talking to CF manufacturers.
> 
> Basically, a CF card is a flash ROM array attached to a little
> microcontroller with an IDE interface.  The large manufacturers generally
> have custom controllers.
> 
I'm actually interested in:

1. CF wear-levelling algorithms: how good or bad is it?
2. How does CF implement block mapping, does it store the mapping table 
on-flash or in memory, does it build it by scanning, how scalable are 
those algorithms.
3. Does CF perform bad erasable blocks hadling transparently when new 
bad eraseblocks appear.
4. How tolerant CF to powrer-offs.
5. Is there a Garbage Collector in CF and how clever/stupid is it.

etc.

I've heard CF does not have good characteristics in the above mentioned 
aspects, but still, it would be interesting to know details. I'm not 
going to use CFs, but as I'm working with flashes, I'm just interested. 
It'd help me explaining people why it is bad to use CF for more serious 
applications then those just storing pictures.

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.

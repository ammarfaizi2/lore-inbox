Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTE2XRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTE2XRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:17:34 -0400
Received: from [62.75.136.201] ([62.75.136.201]:11750 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263163AbTE2XRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:17:33 -0400
Message-ID: <3ED69827.8050601@g-house.de>
Date: Fri, 30 May 2003 01:30:47 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IPv6 module oopsing on 2.5.69
References: <3ED5E9E7.5070602@g-house.de> <20030529.203032.131225364.yoshfuji@wide.ad.jp>
In-Reply-To: <20030529.203032.131225364.yoshfuji@wide.ad.jp>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / ???? schrieb:
> CC: netdev
> 
> Upgrade to 2.5.70 and retest, please.
> Thank you.
> 
> In article <3ED5E9E7.5070602@g-house.de> (at Thu, 29 May 2003 13:07:19 +0200), Christian <evil@g-house.de> says:
> 
>>while booting the ipv6 module gets installed, along with this message in 
>>the log:

perfectly, that did it!

i was not aware of 2.5.70 yet. now i have 2.5.70 running with working 
ipv6 *and* tainted nvidia module.

note: with 2.5.69 the said module was unuseable even when i unloaded the 
tainted module.

Thank you all,
Christian.


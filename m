Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265959AbUFOVpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUFOVpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUFOVpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:45:55 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:9600 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265959AbUFOVpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:45:53 -0400
Message-ID: <40CF6DF7.8070304@zytor.com>
Date: Tue, 15 Jun 2004 14:45:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] Very Trivial - make "After * identify, caps:" messages
 line up
References: <Pine.LNX.4.56.0406152310390.9908@jjulnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0406152310390.9908@jjulnx.backbone.dif.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Visually it's much easier to read/compare messages such as these
> 
> Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> 
> if the numbers line up like this
> 
> Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
> Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify,  caps: 0183f9ff c1c7f9ff 00000000 00000000
> 
> /Very/ minor, trivial thing, yes, but those messages have been annoying my
> eyes for a while now so I desided to make them line up - so, here's the
> patch that does that (not sure if a signed-off-by line is needed even for
> trivial stuff like this, but I assume it should go with everything, so...)
> Patch is against 2.6.7-rc3-mm2
> 

I think that's what the spaces after CPU: was for... apparently that's gotten 
forgotten somehow.  Sigh.  Please put the extra spaces all in one place.

	-hpa

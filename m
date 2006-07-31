Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWGaFHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWGaFHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWGaFHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:07:35 -0400
Received: from stinky.trash.net ([213.144.137.162]:30349 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751490AbWGaFHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:07:34 -0400
Message-ID: <44CD9013.7020401@trash.net>
Date: Mon, 31 Jul 2006 07:07:31 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: david@davidcoulson.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at net/core/dev.c:1171/skb_checksum_help() 2.6.18-rc3
References: <44CD8415.2020403@davidcoulson.net>	<44CD85FF.9010607@trash.net> <20060730.215907.58439803.davem@davemloft.net>
In-Reply-To: <20060730.215907.58439803.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Mon, 31 Jul 2006 06:24:31 +0200
> 
> 
>>This is a known problem with NAT and HW checksum and will probably get
>>fixed in 2.6.19.
> 
> 
> I would like to see this fixed for 2.6.18, no later.
> 
> Either that or disable the bug trap, but taking this route
> is severely discouraged. :)


I'm actually updateing my patch for this on top of Herbert's
CHECKSUM_PARTIAL patch right now. Unfortunately I targeted 2.6.19,
so the fixes are on top of a few cleanups (which unconvered a few
unrelated bugs as well). I'll post it when I'm done so we can
decide how to proceed.


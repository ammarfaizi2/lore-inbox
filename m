Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVBAABt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVBAABt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVBAAAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:00:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:906 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261469AbVAaX5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:57:36 -0500
Message-ID: <41FEC5D0.3070504@pobox.com>
Date: Mon, 31 Jan 2005 18:57:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, ralf@linux-mips.org,
       davem@redhat.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move dp83840.h to Documentation/
References: <20050131234158.GI21437@stusta.de> <20050131154607.70786f2c.davem@davemloft.net>
In-Reply-To: <20050131154607.70786f2c.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 1 Feb 2005 00:41:58 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> 
>>dp83840.h is included once but none of the definitions it contains is
>>actually used.
>>
>>Ralf Baechle wants that it stays as documentation, so this patch moves 
>>it under Documentation/ .
> 
> 
> No, let's kill this thing altogether.  The only driver in the world
> using the CSCONFIG_* defines in there is the sunhme driver and it
> defines it's own macros in drivers/net/sunhme.h  This header is more
> than useless these days.
> 
> The header still exists in older trees and the revision history.
> So people can still get to it there.


agreed



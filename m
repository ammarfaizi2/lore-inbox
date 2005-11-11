Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVKKNRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVKKNRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVKKNRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:17:45 -0500
Received: from mail.collax.com ([213.164.67.137]:51940 "EHLO
	kaber.coreworks.de") by vger.kernel.org with ESMTP id S1750734AbVKKNRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:17:44 -0500
Message-ID: <437499C7.7040302@trash.net>
Date: Fri, 11 Nov 2005 14:16:55 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051011 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: Brian Pomerantz <bapper@piratehaven.org>, netdev@vger.kernel.org,
       davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net> <20051105010740.GR23537@postel.suug.ch> <436C090D.5020201@trash.net> <436C34F8.3090903@trash.net> <20051105134636.GS23537@postel.suug.ch> <20051107215022.GH23537@postel.suug.ch> <4370B203.8070501@trash.net> <20051109005658.GL23537@postel.suug.ch>
In-Reply-To: <20051109005658.GL23537@postel.suug.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:
> * Patrick McHardy <kaber@trash.net> 2005-11-08 15:11
>
>>I have a patch to do this, but it needs some debugging, for some
>>unknown reason it crashes sometimes if I remove addresses without
>>specifying the mask.
>  
> Interesting, do you use an iproute2 version with the wildcard
> address deletion fix attached below?

No, its some old debian version. I'm going to try if it makes a
difference, but it needs to be fixed to work (or at least not crash)
with old versions anyway.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRC0CJK>; Mon, 26 Mar 2001 21:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130439AbRC0CJB>; Mon, 26 Mar 2001 21:09:01 -0500
Received: from [206.191.149.199] ([206.191.149.199]:7 "EHLO
	mail.seattlefirewall.dyndns.org") by vger.kernel.org with ESMTP
	id <S130438AbRC0CIq>; Mon, 26 Mar 2001 21:08:46 -0500
Date: Mon, 26 Mar 2001 18:06:38 -0800 (PST)
From: Tom Eastep <teastep@seattlefirewall.dyndns.org>
To: Frank Jacobberger <f1j@xmission.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3-pre8 problem with 8139too - failure to load
In-Reply-To: <3ABF4D3D.2070401@xmission.com>
Message-ID: <Pine.LNX.4.30.0103261804500.993-100000@wookie.seattlefirewall.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spoke Frank Jacobberger:


> Trying to do insmod 8139too.o from the :
> /lib/modules/2.4.3-pre8/kernel/drivers/net directory show these
> unresolved symbols:
>
> 8139too.o: unresolved symbol alloc_etherdev
> 8139too.o: unresolved symbol unregister_netdev
> 8139too.o: unresolved symbol register_netdev
>

I ran into a similar problem with tulip.o -- I was able to work around the
problem by turning off module versioning (CONFIG_MODVERSIONS).

-Tom
-- 
Tom Eastep             \ Alt Email: tom@seattlefirewall.dyndns.org
ICQ #60745924           \ Websites: http://seawall.sourceforge.net
teastep@evergo.net       \          http://seattlefirewall.dyndns.org
Shoreline, Washington USA \         http://shorewall.sourceforge.net
                           \_________________________________________


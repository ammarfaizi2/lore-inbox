Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbULZUWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbULZUWG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbULZUWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:22:06 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:16019 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261155AbULZUWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:22:01 -0500
In-Reply-To: <20041226171900.GA27706@work.bitmover.com>
References: <1104077531.5268.32.camel@mulgrave> <20041226162727.GA27116@work.bitmover.com> <1104079394.5268.34.camel@mulgrave> <20041226171900.GA27706@work.bitmover.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <92984B55-577B-11D9-BCB8-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
From: Martin Dalecki <martin@dalecki.de>
Subject: Re: [BK] disconnected operation
Date: Sun, 26 Dec 2004 21:20:23 +0100
To: Larry McVoy <lm@bitmover.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-26, at 18:19, Larry McVoy wrote:
> For James, could you do a little debugging please?  Run the following
> when you are plugged in and it works and also when it doesn't:
>
> 	bk getuser
> 	bk getuser -r
> 	bk gethost
> 	bk gethost -r
> 	bk dotbk
>
> We'll track it down and fix it if it is a problem on our end.  This 
> stuff
> is supposed to work, we certainly haven't intentionally caused a 
> problem.

Larry, that's futile, please trust me, you really can't fix this 
conveniently
and properly, without changing the principles of operation. nscd, 
mDNSresponder,
dhclient, glibc, NDIS, netinfo, some NAT, proxy, OpenDirectory, and so 
on, the whole gang,
gosh even /etc/hostname will *always* get you sometime if you intend to
accommodate mobile users. Eee... did I say mobile users, Well let's use 
the proper
buzz-word. *Roaming* users.  Take it as a given: The nice shiny easy 
days of BSD4-Net
release are long past and gone. A hostname simply isn't a fixed 
attribute of a host anymore.
Setting a host name has nowadays more the character of a prayer or 
christmas wish to Santa,
then any setup measure.

I really recommend that you give him a cookie and check if he still 
didn't eat it
next time you meet him. (So don't give him a crispy well smelling 
one...)
Or even better please do yourself the favor and go straight the whole 
way down to
SASL, TSL and so on... There where already people around there with 
similar problems before.
(www.beepcore.org comes in to mind for something quite modern and not 
directly
Java/XML/SOAP/bla bla bloated...)


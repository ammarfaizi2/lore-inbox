Return-Path: <linux-kernel-owner+w=401wt.eu-S932720AbWLaEOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWLaEOk (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 23:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWLaEOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 23:14:40 -0500
Received: from squeaker.ratbox.org ([66.212.148.233]:50953 "EHLO
	squeaker.ratbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720AbWLaEOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 23:14:39 -0500
Date: Sat, 30 Dec 2006 23:14:38 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net, st3@riseup.net,
       linville@tuxdriver.com, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OOPS] bcm43xx oops on 2.6.20-rc1 on x86_64
In-Reply-To: <20061230192104.GB20714@stusta.de>
Message-ID: <Pine.LNX.4.64.0612302312520.27190@squeaker.ratbox.org>
References: <Pine.LNX.4.64.0612171510030.17532@squeaker.ratbox.org>
 <20061230192104.GB20714@stusta.de>
X-Reply-UID: (2 > )(1 1167538359 994)/home/androsyn/maildir/INBOX/
X-Reply-Mbox: /home/androsyn/maildir/INBOX/
X-Cursor-Pos: : 512
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Dec 2006, Adrian Bunk wrote:

> On Sun, Dec 17, 2006 at 03:15:28PM -0500, Aaron Sethman wrote:
>>
>> Just was loading the bcm43xx module and got the following oops. Note that
>> this card is one of the newer PCI-E cards.  If any other info is needed
>> let me know.
>
> Is this issue still present in 2.6.10-rc2-git1?
>
> If yes, was 2.6.19 working fine?
>

This seems to be fixed in 2.6.20-rc2-git1.  Still having other issues 
with the driver, but the oops in the SoftMAC code is resolved now at 
least.

-Aaron

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUC2D5c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 22:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUC2D5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 22:57:32 -0500
Received: from mail.tmr.com ([216.238.38.203]:3210 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262592AbUC2D5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 22:57:30 -0500
Message-ID: <40679ED8.1060502@tmr.com>
Date: Sun, 28 Mar 2004 22:58:16 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jad Saklawi <jad@saklawi.info>
CC: linux-kernel@vger.kernel.org, hisham@hisham.cc, llug-users@greencedars.org
Subject: Re: Fwd: MAC / IP conflict
References: <405D239B.30602@mail.portland.co.uk>
In-Reply-To: <405D239B.30602@mail.portland.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jad Saklawi wrote:
> ----- Forwarded message from Hisham Mardam Bey -----
>    Date: Sun, 21 Mar 2004 13:52:59 +0200
> 
> In short, I need to detect when someone on the network uses my MAC and
> my IP address.
> 
> Longer story follows. I am on a LAN which might have some potentially
> dangerous users. Those users might spoof my MAC address and additionally
> use my IP address, thus forcing my box to go offline, and not be able to
> communicate with my gateway. What I need is a passive way to check for
> something of the sort, and perhaps a notofication into syslog (the
> latter is not very important).

Use arpwatch, it detects ALL changes of IP<=>MAC mapping.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

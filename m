Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVFISLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVFISLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVFISLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 14:11:17 -0400
Received: from falcon30.maxeymade.com ([24.173.215.190]:41692 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S261400AbVFISLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 14:11:13 -0400
Message-Id: <200506091809.j59I9WUb001296@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.2.1 01/17/2005 with nmh-1.1
In-reply-to: <20050609175859.GA22182@ee.oulu.fi> 
To: Sami Tapio <flexy@ee.oulu.fi>
cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: tcp_output.c BUG in 2.6.12-rc6-mm1 report 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Jun 2005 13:09:32 -0500
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Jun 2005 20:58:59 +0300, Sami Tapio wrote:
>On Wed, Jun 08, 2005 at 12:46:26PM -0700, David S. Miller wrote:
>> 
>> Just remove the BUG_ON() statement in tcp_tso_should_defer(), the
>> assertion is just incorrect.
>
>Well, don't know if it is incorrect or not, but my machine just 
>hard locked again, no reaction to SysRQ SUB sequence, no reaction 
>to anything else either, not answer to ping, nor ssh. Power off, 
>power on was the only method to get the machine alive again. 
>
>Only thing in the logs is the bug I've allready reported 2 times. 
>Don't know if that bug is real or not, but the problem is real 
>for sure.
>

I see these on a ICH5 based system.  Are you running wine by chance?

++doug


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWFNXDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWFNXDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWFNXDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:03:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31211
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964994AbWFNXDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:03:46 -0400
Date: Wed, 14 Jun 2006 16:04:04 -0700 (PDT)
Message-Id: <20060614.160404.132445434.davem@davemloft.net>
To: bofh1234567@yahoo.com
Cc: alan@lxorguk.ukuu.org.uk, jengelh@linux01.gwdg.de,
       linux-kernel@vger.kernel.org
Subject: Re: SO_REUSEPORT and multicasting
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060614225701.93656.qmail@web53611.mail.yahoo.com>
References: <20060614.151418.32173686.davem@davemloft.net>
	<20060614225701.93656.qmail@web53611.mail.yahoo.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason <bofh1234567@yahoo.com>
Date: Wed, 14 Jun 2006 15:57:01 -0700 (PDT)

> I agree that I don't want to start a flamewar or get
> off topic.  However, I did state earlier that I did
> switch to use SO_REUSEADDR and while the program
> compiled on Linux (without error) the server did not
> receive any packets.  Hence my questions regarding
> Linux supporting multicasting.  

We do have a mailing list where the networking developers
actually hang out, netdev@vger.kernel.org

It seems you're not configuring the multicast route correctly
or something like that, the socket stuff should all work just
fine because David Stevens at IBM is testing this stuff all
the time.

Why don't you move your multicast route setup questions over
to the netdev list?

Thanks.

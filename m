Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVFIGQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVFIGQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVFIGO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:14:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50854
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262246AbVFIGN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:13:27 -0400
Date: Wed, 08 Jun 2005 23:13:19 -0700 (PDT)
Message-Id: <20050608.231319.95056824.davem@davemloft.net>
To: jgarzik@pobox.com
Cc: jketreno@linux.intel.com, vda@ilport.com.ua, pavel@ucw.cz,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42A7DC4D.7000008@pobox.com>
References: <42A7268D.9020402@linux.intel.com>
	<20050608.124332.85408883.davem@davemloft.net>
	<42A7DC4D.7000008@pobox.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jgarzik@pobox.com>
Date: Thu, 09 Jun 2005 02:06:05 -0400

> Therefore, the easiest way to make things work today is to poke Intel to 
> fix their firmware license so that we can distribute it with the kernel :)

Seperate firmware from the in-kernel driver is a big headache for
users.  As DaveJ has stated, people make mistakes and try to match up
the wrong firmware version with the driver and stuff like that.  And
he should know as he has to deal sift through bogus bug reports from
people running into this problem.

If it's integrated, there are no problems like this.

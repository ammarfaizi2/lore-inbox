Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWEHSiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWEHSiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWEHSiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:38:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6310
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932504AbWEHSiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:38:51 -0400
Date: Mon, 08 May 2006 11:38:42 -0700 (PDT)
Message-Id: <20060508.113842.82892402.davem@davemloft.net>
To: hswong3i@gmail.com
Cc: pavel@suse.cz, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP congestion module: add TCP-LP supporting for
 2.6.16.14
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <3feffd230605081050x104461fcj76f2821cfc311a6e@mail.gmail.com>
References: <20060508112915.GB4162@ucw.cz>
	<20060508.104322.58430929.davem@davemloft.net>
	<3feffd230605081050x104461fcj76f2821cfc311a6e@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wong Edison" <hswong3i@gmail.com>
Date: Tue, 9 May 2006 01:50:36 +0800

> > Or, just include it, and select it with the TCP_CONGESTION socket
> > option when you want it.  Sorry, this does require app modifications.
> 
> i would like to have more information about this
> so within the app
> after create the socket
> then call setsockopt (!?)
> to set the TCP_CONGESTION into "lp" (in my case) ??
> 
> is that means the socket's congestion algorithm will then be what i set ??
> in this socket within this app only ??

Yes, it applies to the socket.

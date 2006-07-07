Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWGGTLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWGGTLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGGTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:11:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9105
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932271AbWGGTLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:11:14 -0400
Date: Fri, 07 Jul 2006 12:11:45 -0700 (PDT)
Message-Id: <20060707.121145.61973582.davem@davemloft.net>
To: arjan@infradead.org
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: more rc1 lockdep fun.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1152299015.3111.138.camel@laptopd505.fenrus.org>
References: <20060707185848.GA5818@redhat.com>
	<1152299015.3111.138.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Fri, 07 Jul 2006 21:03:35 +0200

> On Fri, 2006-07-07 at 14:58 -0400, Dave Jones wrote:
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > -------------------------------------------------------
> > gnome-settings-/3278 is trying to acquire lock:
> >  (sk_lock-AF_INET){--..}, at: [<ffffffff8022800c>] tcp_sendmsg+0x1f/0xb1a
> 
> 
> this appears to be the same one as the "mc" one I just looked at.

This is what I think too, I'll look at Arjan's analysis later this
afternoon.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSLDTdz>; Wed, 4 Dec 2002 14:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSLDTdz>; Wed, 4 Dec 2002 14:33:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:30919 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267038AbSLDTdy>;
	Wed, 4 Dec 2002 14:33:54 -0500
Subject: RE: [PATCH] NMI notifiers for 2.5
From: Stephen Hemminger <shemminger@osdl.org>
To: Larry Sendlosky <Larry.Sendlosky@storigen.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <7BFCE5F1EF28D64198522688F5449D5AC632EE@xchangeserver2.storigen.com>
References: <7BFCE5F1EF28D64198522688F5449D5AC632EE@xchangeserver2.storigen.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 11:41:25 -0800
Message-Id: <1039030885.20417.16.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 11:20, Larry Sendlosky wrote:
> Why not just use the panic notifier callback? After all, isn't
> an "NMI timeout" just another type of panic? Is there code
> that needs to take different action on an NMI timeout than a panic?
> 
> larry

That is a possibility but the arguments available are different.
panic has the string and NMI has the registers available.

Could also include oops handler as well.


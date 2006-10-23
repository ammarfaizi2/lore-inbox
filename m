Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWJWVTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWJWVTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWJWVTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:19:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14046
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751678AbWJWVTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:19:20 -0400
Date: Mon, 23 Oct 2006 14:19:19 -0700 (PDT)
Message-Id: <20061023.141919.115911218.davem@davemloft.net>
To: jeff.chua.linux@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.19-rc2 tg3 problem
From: David Miller <davem@davemloft.net>
In-Reply-To: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Date: Mon, 23 Oct 2006 23:24:14 +0800

> I'm getting this error on with linux 2.6.19-rc2 with tg3 module, even
> with patching to v3.66 ...

You've posted this about 4 times, you can be sure we've seen every one
of them, please don't post it again ok? :-)  Just wait patiently for
someone to look at this problem, thanks.

FWIW, this looks like it has been caused by some platform specific
or generic PCI layer changes.  It doesn't look like a tg3 driver
bug at all, as it's just looking for the PCI resource for the
register mapping which should always just work if the PCI layer
is behaving.



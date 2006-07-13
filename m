Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWGMUXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWGMUXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWGMUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:23:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23480
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030358AbWGMUXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:23:35 -0400
Date: Thu, 13 Jul 2006 13:23:38 -0700 (PDT)
Message-Id: <20060713.132338.48528902.davem@davemloft.net>
To: jima@beer.tclug.org
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0607130836140.13948@beer.tclug.org>
References: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
	<Pine.LNX.4.64.0607130836140.13948@beer.tclug.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jima <jima@beer.tclug.org>
Date: Thu, 13 Jul 2006 08:38:28 -0500 (CDT)

>   I don't know about you, but my Ultra 5 has two: the DB25 female
> connector on the board ("A"), and the DB9 male connector on a ribbon
> cable ("B").  This is going off memory, but I'm fairly confident of
> this.

The 'se' device has two ports.  It seems one of them is not
getting registered properly or something like that.  I'll
take a look.

The DB9 one is in fact labelled "B" on the back of my ultra5.

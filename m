Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWATUHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWATUHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWATUHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:07:18 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33413
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932129AbWATUHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:07:16 -0500
Date: Fri, 20 Jan 2006 12:02:48 -0800 (PST)
Message-Id: <20060120.120248.93468025.davem@davemloft.net>
To: torvalds@osdl.org
Cc: bboissin@gmail.com, laforge@netfilter.org, xslaby@fi.muni.cz,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Iptables error
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
References: <20060120163619.GK4603@sunbeam.de.gnumonks.org>
	<40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
	<Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 20 Jan 2006 11:49:46 -0500 (EST)

> Interestingly, __alignof__(unsigned long long) is 8 these days, even 
> though I think historically on x86 it was 4. Is this perhaps different in 
> gcc-3 and gcc-4?
> 
> Or do I just remember wrong?

I think I remember the gcc folks talking about changing this
some time long in the past, aparently they did.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWATQu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWATQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWATQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:50:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751086AbWATQu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:50:57 -0500
Date: Fri, 20 Jan 2006 11:49:46 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benoit Boissinot <bboissin@gmail.com>
cc: Harald Welte <laforge@netfilter.org>, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S.Miller" <davem@davemloft.net>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
In-Reply-To: <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
References: <20060120031555.7b6d65b7.akpm@osdl.org> 
 <20060120162317.5F70722B383@anxur.fi.muni.cz>  <20060120163619.GK4603@sunbeam.de.gnumonks.org>
 <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Jan 2006, Benoit Boissinot wrote:
> 
> On x86 (32bits), i have the same i think:

Interestingly, __alignof__(unsigned long long) is 8 these days, even 
though I think historically on x86 it was 4. Is this perhaps different in 
gcc-3 and gcc-4?

Or do I just remember wrong?

		Linus

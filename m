Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSJXD7o>; Wed, 23 Oct 2002 23:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265307AbSJXD7o>; Wed, 23 Oct 2002 23:59:44 -0400
Received: from rth.ninka.net ([216.101.162.244]:49047 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265306AbSJXD7o>;
	Wed, 23 Oct 2002 23:59:44 -0400
Subject: Re: [PATCH] New ARPHRD types
From: "David S. Miller" <davem@rth.ninka.net>
To: Solomon Peachy <solomon@linux-wlan.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021023141651.GA6644@linux-wlan.com>
References: <20021021221936.GA32390@linux-wlan.com>
	<1035330936.16084.23.camel@rth.ninka.net> 
	<20021023141651.GA6644@linux-wlan.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 21:18:00 -0700
Message-Id: <1035433080.9629.8.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 07:16, Solomon Peachy wrote:
> Oh, I completely agree.  Unfortunately, the underlying problem is that
> the IEEE 802.11 spec has a variable-length hardware header, and that's
> not fixable, ruby slippers or no.

I'm not allowing you to put a hack special ARP header type into
the kernel when the real fix is to clean up the 802.11 handling
in the entire tree.

If that means every ethernet driver has to be aware of variable length
headers potentially, so be it.

This is the second time I'm saying this.

I'm not going to address the compression bits until you resolve this
and fix the problem properly instead of proposing hacks.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSHAQKj>; Thu, 1 Aug 2002 12:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSHAQKj>; Thu, 1 Aug 2002 12:10:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39408 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315634AbSHAQKi>; Thu, 1 Aug 2002 12:10:38 -0400
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for
	2.5.29)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
In-Reply-To: <Pine.LNX.4.44.0208010903460.14537-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208010903460.14537-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 18:30:41 +0100
Message-Id: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 17:09, Linus Torvalds wrote:
> However, "jiffies" are not really real time, they are only a "reasonable
> abstraction thereof", and while they imply ordering ("time_after()" works
> fine inside the kernel), they do _not_ imply real time.
> 
> In other words, there is no way to move from time -> jiffies and back.

For a lot of applications like multimedia you actually want a counting
of time not any relation to real time except that you can tell how many
ticks elapse a second.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267304AbSLKUkA>; Wed, 11 Dec 2002 15:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbSLKUkA>; Wed, 11 Dec 2002 15:40:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6306 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267304AbSLKUj7>;
	Wed, 11 Dec 2002 15:39:59 -0500
Date: Wed, 11 Dec 2002 12:43:47 -0800 (PST)
Message-Id: <20021211.124347.127990341.davem@redhat.com>
To: jsimmons@infradead.org
Cc: benh@kernel.crashing.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: atyfb in 2.5.51
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
References: <1039596149.24691.2.camel@rth.ninka.net>
	<Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Simmons <jsimmons@infradead.org>
   Date: Wed, 11 Dec 2002 07:16:04 -0800 (PST)
   
   I agree that the design of the /dev/fbX interface is not the best.
   Unfortunely we are stuck with it. Changing it would break userland apps.
   
I totally understand.  I do not suggest to break fbdev in it's current
form, too much stuff uses it.

My main point was, don't be surprised the X servers, like the ATI
driver, don't use fbdev and instead just mmap the device and simply
program it directly.

fbdev is nice, in the specific cases where the device fits the fbdev
model, because once you have the kernel bits you have X support :)

Franks a lot,
David S. Miller
davem@redhat.com

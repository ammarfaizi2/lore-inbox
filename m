Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUHGOef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUHGOef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 10:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUHGOee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 10:34:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:63681 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262837AbUHGOdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 10:33:55 -0400
Subject: Re: DRM function pointer work..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Ian Romanick <idr@us.ibm.com>,
       Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040806171641.14189.qmail@web14928.mail.yahoo.com>
References: <20040806171641.14189.qmail@web14928.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091885466.18408.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 14:31:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 18:16, Jon Smirl wrote:
> fbdev is in exactly this model and it isn't causing anyone problems.
> The simple rule is that if you want to upgrade fbdev past the current
> version you have to do it in entirety. You do that for fbdev but
> pulling bk://fbdev.bkbits.net/. But Joe user doesn't do that, that is
> something only developers do.

And thats one of the big reasons its such a mess and doesn't work out.
Nobody is testing or reviewing it until some huge "merge point" occurs
at which point you run the risk of people saying "Actually your design
sucks", or in the 2.6 case finding out too late so that there is a patch
kit to upgrade your 2.6 to the 2.4 console driver


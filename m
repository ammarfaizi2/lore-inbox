Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSJIMeM>; Wed, 9 Oct 2002 08:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSJIMdh>; Wed, 9 Oct 2002 08:33:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36527 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261711AbSJIMdH>;
	Wed, 9 Oct 2002 08:33:07 -0400
Date: Wed, 09 Oct 2002 05:31:39 -0700 (PDT)
Message-Id: <20021009.053139.92842849.davem@redhat.com>
To: willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Second round of ioctl cleanups
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021009133337.Y18545@parcelfarce.linux.theplanet.co.uk>
References: <20021008000948.O18545@parcelfarce.linux.theplanet.co.uk>
	<20021008.212052.61268086.davem@redhat.com>
	<20021009133337.Y18545@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Wed, 9 Oct 2002 13:33:37 +0100
   
   would it be ok to move these credits to net/socket.c?  it shows false
   positives when grepping otherwise.

No, look we still get to mention "invalidate()" in mm/memory.c, we can
keep ancient "not accurate at all today" reminders of our past in the
networking too.

It's just too rude to move the credits after they've been there all
this time.

If at some point we move all of the credits to some master log
somewhere, that might be something we could do, but that's
like 2.7.x I guess :-)


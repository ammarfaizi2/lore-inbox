Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJQWI6>; Thu, 17 Oct 2002 18:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbSJQWI6>; Thu, 17 Oct 2002 18:08:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42943 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262215AbSJQWIz>;
	Thu, 17 Oct 2002 18:08:55 -0400
Date: Thu, 17 Oct 2002 15:07:22 -0700 (PDT)
Message-Id: <20021017.150722.101474043.davem@redhat.com>
To: greg@kroah.com
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017220956.GC1533@kroah.com>
References: <20021017205830.GD592@kroah.com>
	<20021017.135832.54206778.davem@redhat.com>
	<20021017220956.GC1533@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Thu, 17 Oct 2002 15:09:57 -0700

   > 2.5.x is busting at the seams currently and CONFIG_SECURITY is part of
   > the reason why.
   
   With the patch I just sent, that size issue should be resolved.
   
I really apprecite that you've done this work Greg.
Thank you.

   > I need to convince you to implement this in a way, so that like
   > USB, there is zero overhead when I enable it as a module. :-)
   
   I would love to implement it in such a manner.  Without using
   self-modifying code, do you have any ideas of how this could be done?
   
Yes, I agree it's a difficult problem.

My main point is, don't compare the security bloat to USB, because in
the USB case if I don't use it I get no space/time consumption even if
I have it enabled (as a module).  This is not true for the security
bits.

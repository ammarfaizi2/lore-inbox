Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263242AbSJCLQi>; Thu, 3 Oct 2002 07:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJCLQi>; Thu, 3 Oct 2002 07:16:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7889 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263240AbSJCLQg>;
	Thu, 3 Oct 2002 07:16:36 -0400
Date: Thu, 03 Oct 2002 04:14:49 -0700 (PDT)
Message-Id: <20021003.041449.58450031.davem@redhat.com>
To: linux_learning@yahoo.co.uk
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: this code does not get called in dev.c so do we need it?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003111356.51794.qmail@web13101.mail.yahoo.com>
References: <20021002.171042.42890215.davem@redhat.com>
	<20021003111356.51794.qmail@web13101.mail.yahoo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: will fitzgerald <linux_learning@yahoo.co.uk>
   Date: Thu, 3 Oct 2002 12:13:56 +0100 (BST)

   you say that fast routing occurs in the device driver
   level. 
   how does it send a packet from router eth0 to router
   eth1? 
   is it on the bus? (is this like zero copy jumping from
   one device directly to another?)
   
It passes the packet directly to the output method of
the target device for the route.  Just like I said in
my original email, nothing more nothing less.

   if fast routing saves time in not having to go to the
   ip layer why is it not used alll the time? 
   
Because it is used only by a limited number of people
and it makes drivers harder to maintain since very few
people have the setups necessary to test this feature
properly.

   is it buggy? 

No.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTFGGsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTFGGsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:48:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12931 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262589AbTFGGsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:48:51 -0400
Date: Fri, 06 Jun 2003 23:59:46 -0700 (PDT)
Message-Id: <20030606.235946.59661586.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306070047.h570lfsG003377@ginger.cmf.nrl.navy.mil>
References: <20030606210620.G3232@almesberger.net>
	<200306070047.h570lfsG003377@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Fri, 06 Jun 2003 20:45:51 -0400

   really?  if i remove my ethernet interface i expect all the
   connections to die.
   
Nope, this actually works.

Many a moon ago, we did this wrong and yes the TCP connections
died.

But these days, definitely if you bring the interface back up
with the same IP addresses, it just works and the connections
recover.

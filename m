Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262577AbSJGRZi>; Mon, 7 Oct 2002 13:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbSJGRZh>; Mon, 7 Oct 2002 13:25:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10907 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262577AbSJGRZg>;
	Mon, 7 Oct 2002 13:25:36 -0400
Date: Mon, 07 Oct 2002 10:24:26 -0700 (PDT)
Message-Id: <20021007.102426.48670437.davem@redhat.com>
To: simon@baydel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA1CF36.19659.13D4209@localhost>
References: <3DA16A9B.7624.4B0397@localhost>
	<20021007.033644.85392050.davem@redhat.com>
	<3DA1CF36.19659.13D4209@localhost>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "" <simon@baydel.com>
   Date: Mon, 7 Oct 2002 18:15:18 +0100
   
   Although I don't understand why anyone would want it. Apart
   from API changes, why do this ?

Let's say your driver is the only one that takes advantage
of argument X in some major API, and we decided to delete
that argument.

If your driver is in the tree we wouldn't delete the argument
and therefore your driver wouldn't break.

You may not have any desire to upgrade kernels today.
But 6 months, or a year or two down the road you may
and the accumulated ABI changes that you have to cope with
in each and every one of your drivers will be large.
Why not get this maintainence done for you for free instead
of losing a week or two of trying to do it yourself?

Perhaps for job security? :-)  At least that would be an honest
reason.


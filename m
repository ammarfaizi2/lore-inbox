Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143717AbRAHNtr>; Mon, 8 Jan 2001 08:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143622AbRAHNti>; Mon, 8 Jan 2001 08:49:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61574 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S143717AbRAHNtU>;
	Mon, 8 Jan 2001 08:49:20 -0500
Date: Mon, 8 Jan 2001 05:31:54 -0800
Message-Id: <200101081331.FAA18576@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: mike@khi.sdnpk.org
CC: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.UiT.No
In-Reply-To: <3A59C316.8001E42A@khi.sdnpk.org> (message from Ansari on Mon, 08
	Jan 2001 18:39:34 +0500)
Subject: Re: Delay in authentication.
In-Reply-To: <3A59C316.8001E42A@khi.sdnpk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 08 Jan 2001 18:39:34 +0500
   From: Ansari <mike@khi.sdnpk.org>

   I just installed Redhat 6.0. When i run "su" command it takes much
   time to apper passwd prompt.  Its also taking much time in
   authentication after entering the password.

This definitely seems like the classic "/etc/nsswitch.conf is told to
look for YP servers and you are not using YP", so have a look and fix
nsswitch.conf if this is in fact the problem.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

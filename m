Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTEZByf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 21:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTEZByf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 21:54:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4743 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263833AbTEZBye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 21:54:34 -0400
Date: Sun, 25 May 2003 19:07:10 -0700 (PDT)
Message-Id: <20030525.190710.112599236.davem@redhat.com>
To: torvalds@transmeta.com
Cc: viro@parcelfarce.linux.theplanet.co.uk, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: netlink init order
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305251511140.1741-100000@home.transmeta.com>
References: <20030525220709.GJ6270@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.44.0305251511140.1741-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 25 May 2003 15:12:28 -0700 (PDT)
   
   Davem? Who uses this thing?
   
[ was away past 2 days, sorry... ]

I doubt any users of netlink "devices" exist in nature anymore.
I remember in 2.2.x we marked it as deprecated. :-)
   
That being said, you should be able to safely use module_init() there.

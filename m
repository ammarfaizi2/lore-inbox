Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTEZCnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 22:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTEZCnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 22:43:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43399 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263875AbTEZCnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 22:43:04 -0400
Date: Sun, 25 May 2003 19:55:41 -0700 (PDT)
Message-Id: <20030525.195541.55750468.davem@redhat.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: netlink init order
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030526025016.GM6270@parcelfarce.linux.theplanet.co.uk>
References: <20030525.190710.112599236.davem@redhat.com>
	<Pine.LNX.4.44.0305251922310.1621-100000@home.transmeta.com>
	<20030526025016.GM6270@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: viro@parcelfarce.linux.theplanet.co.uk
   Date: Mon, 26 May 2003 03:50:16 +0100

   Err...  That should be
   
   +module_init(init_netlink)
   +module_exit(cleanup_netlink)
   
That's exactly what I said.

Al, are you able to read any of my emails?  I sent you one last week
with a patch for fs/proc/task_mmu.c warnings on 64-bit and it
aparently went to the bit bucket... maybe all my mails aren't
making it your way :(


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270649AbTHACkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 22:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270650AbTHACkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 22:40:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:26250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270649AbTHACkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 22:40:09 -0400
Date: Thu, 31 Jul 2003 19:39:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, <arjanv@redhat.com>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting. 
In-Reply-To: <20030727193919.832302C450@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0307311939050.15919-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jul 2003, Rusty Russell wrote:
> 
> I guess it's back to fixing up reference counting in the rest of the
> kernel.  It's not hard, it's just not done. 8(

Well, it's _never_ been done, so saying "we have to fix it for 2.6.x" is 
obviously not true. It's one of those "nobody ends up really caring" 
issues, since only root can unload anyway.

		Linus


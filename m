Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbTGZTQY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbTGZTQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:16:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:55478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267491AbTGZTQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:16:23 -0400
Date: Sat, 26 Jul 2003 12:31:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, <arjanv@redhat.com>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting. 
In-Reply-To: <20030726172139.348342C24B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First off - we're not changing fundamental module stuff any more.

On Sat, 26 Jul 2003, Rusty Russell wrote:
> 
> No, it would just leak memory.  Not really a concern for developers.
> It's fairly trivial to hack up a backdoor "remove all freed modules
> and be damned" thing for developers if there's real demand.

It's not just a developer thing. At least installers etc used to do some 
device probing by loading modules and depending on the result.

		Linus


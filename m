Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVLQAba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVLQAba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLQAba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:31:30 -0500
Received: from users.ccur.com ([66.10.65.2]:45995 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932552AbVLQAb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:31:29 -0500
Date: Fri, 16 Dec 2005 19:29:29 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051217002929.GA7151@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org> <20051215112115.7c4bfbea.akpm@osdl.org> <1134678532.13138.44.camel@localhost.localdomain> <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be> <1134769269.2806.17.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org> <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org> <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 02:41:16PM -0800, Linus Torvalds wrote:

> "Friends don't let friends use priority inheritance".
> 
> Just don't do it. If you really need it, your system is broken anyway.

The Mars Pathfinder incident is sufficient proof that some solution to
the priority inversion problem is required in real systems.

	http://www.cs.cmu.edu/afs/cs/user/raj/www/mars.html

Regards,
Joe
--
"All the revision in the world will not save a bad first draft, for the
architecture of the thing comes, or fails to come, in the first conception,
and revision only affects the detail and ornament. -- T.E. Lawrence

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVLSXq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVLSXq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 18:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVLSXq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 18:46:29 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:58564 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750706AbVLSXq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 18:46:28 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joe Korty <joe.korty@ccur.com>, Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-reply-to: Your message of "Fri, 16 Dec 2005 17:00:09 -0800."
             <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Dec 2005 10:46:14 +1100
Message-ID: <20054.1135035974@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2005 17:00:09 -0800 (PST),
Linus Torvalds <torvalds@osdl.org> wrote:
>The Mars Pathfinder is just about the worst case "real system", and if I
>recall correctly, the reason it was able to continue was _not_ because it
>handled priority inversion, but because it reset itself every 24 hours or
>something like that, and had debugging facilities..
>...
>So put a watchdog on your critical systems, and make sure you can debug
>them. Especially if they're on Mars.

Who are you and what have you done with the real[1]

  Linus "I'm a sick and twisted person, and I trust people who write code
  without debuggers a lot more than I trust those who don't" Torvalds :-)

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/9510/0103.html


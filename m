Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWJCD1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWJCD1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 23:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJCD1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 23:27:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932313AbWJCD1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 23:27:08 -0400
Date: Mon, 2 Oct 2006 20:23:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
Message-Id: <20061002202328.4249df11.akpm@osdl.org>
In-Reply-To: <20061001225720.115967000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2006 23:00:45 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> We did not address the GTOD patches, as we want to wait for John's input on
> your comments.

I note that the default CONFIG_HIGH_RES_RESOLUTION is still 1000 (one
microsecond), which is far higher resolution than you actually recommend.

I did query that last time around.  I'd prefer not to have to go back and
re-review it all, please...

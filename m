Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbUATBd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUATBd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:33:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:5790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265179AbUATBb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:31:29 -0500
Date: Mon, 19 Jan 2004 17:31:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Petri Koistinen <petri.koistinen@iki.fi>
Cc: sct@redhat.com, akpm@digeo.com, adilger@clusterfs.com,
       hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.1 perhaps ext3 or fat releated crash
Message-Id: <20040119173127.5079491a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401200259140.982@dsl-hkigw4j21.dial.inet.fi>
References: <Pine.LNX.4.58.0401200259140.982@dsl-hkigw4j21.dial.inet.fi>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petri Koistinen <petri.koistinen@iki.fi> wrote:
>
> Kernel crashed (jammed) and I had to reboot manually.

hmm, don't know, sorry.  A random kernel crash in a code path which half
the people in the known universe run 100 times per second makes one think
of hardware problems, or a random memory scribble by some other part of the
kernel.

If it is repeatable, try turning on all the memory debugging options in the
"kernel hacking" menu.


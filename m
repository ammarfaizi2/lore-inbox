Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbUKVG2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUKVG2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 01:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUKVG2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 01:28:11 -0500
Received: from mail.cs.tamu.edu ([128.194.138.12]:53985 "EHLO pine.cs.tamu.edu")
	by vger.kernel.org with ESMTP id S261946AbUKVG2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 01:28:08 -0500
Date: Mon, 22 Nov 2004 00:28:07 -0600 (CST)
From: Erik Mckee <emckee@cs.tamu.edu>
To: linux-kernel@vger.kernel.org
Subject: Divide Error in tcp_set_skb_tso_segs
Message-ID: <Pine.GSO.4.58.0411220024010.13219@unix.cs.tamu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am running 2.4.10-rc2 and I have now gotten two instances of the above
oops.  I haven't managed to record the oops message for it as of yet.  I
am connecting to the internet over ppp.  IIRC, it has appeared both times
after ssh-ing to my email provider and running pine.  I'm not sure if this
had anything to do with it or not.  I rembmer that there are some do_IRQ
and do_softirq stuff in the traceback, along with something like a line of
========='s....  This is with a non tainted kernel, compiled with GCC 3.4
with PREEMPT turned on...

I can try to collect more information if it is desired....I am not on the
list, so please CC me with any replies...

TIA
Erik

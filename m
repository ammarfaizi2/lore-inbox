Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbUK3GVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUK3GVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbUK3GVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:21:48 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:54457
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262011AbUK3GVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:21:47 -0500
Date: Mon, 29 Nov 2004 22:19:10 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo.tosatti@cyclades.com, alan@lxorguk.ukuu.org.uk,
       bgagnon@coradiant.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-Id: <20041129221910.46fe6e43.davem@davemloft.net>
In-Reply-To: <20041130041656.GO4365@dualathlon.random>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com>
	<20041015182352.GA4937@logos.cnet>
	<1097980764.13226.21.camel@localhost.localdomain>
	<20041125150206.GF16633@logos.cnet>
	<20041125203248.GD5904@dualathlon.random>
	<20041125171242.GL16633@logos.cnet>
	<20041125231313.GG5904@dualathlon.random>
	<20041125194509.GN16633@logos.cnet>
	<20041126010423.GI5904@dualathlon.random>
	<20041129200331.3cbcab70.davem@davemloft.net>
	<20041130041656.GO4365@dualathlon.random>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 05:16:56 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> hmm strange, I would suggest to put a dump_stack here to see where it
> triggers:

Nevermind everyone, it's not the get_user_pages() changes.
It's something else happening in 2.4.29-pre1 which is buggering
up sparc64.

False alarm, sorry :-)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbUK3EGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbUK3EGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUK3EGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:06:17 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:18104
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261968AbUK3EGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:06:16 -0500
Date: Mon, 29 Nov 2004 20:03:31 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo.tosatti@cyclades.com, alan@lxorguk.ukuu.org.uk,
       bgagnon@coradiant.com, linux-kernel@vger.kernel.org, andrea@novell.com,
       davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-Id: <20041129200331.3cbcab70.davem@davemloft.net>
In-Reply-To: <20041126010423.GI5904@dualathlon.random>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com>
	<20041015182352.GA4937@logos.cnet>
	<1097980764.13226.21.camel@localhost.localdomain>
	<20041125150206.GF16633@logos.cnet>
	<20041125203248.GD5904@dualathlon.random>
	<20041125171242.GL16633@logos.cnet>
	<20041125231313.GG5904@dualathlon.random>
	<20041125194509.GN16633@logos.cnet>
	<20041126010423.GI5904@dualathlon.random>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These changes have made 2.4.29-BK stop booting on sparc64.
I'll get more information to find out exactly why.

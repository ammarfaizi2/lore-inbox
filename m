Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268407AbUILBII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268407AbUILBII (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 21:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUILBII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 21:08:08 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:5017
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268407AbUILBIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 21:08:06 -0400
Date: Sat, 11 Sep 2004 18:06:57 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Yaroslav Halchenko <mutt@onerussian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crash of -bk17.  bad: scheduling while atomic!
Message-Id: <20040911180657.6e6ed56d.davem@davemloft.net>
In-Reply-To: <20040911153136.GG6735@washoe.rutgers.edu>
References: <20040911153136.GG6735@washoe.rutgers.edu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You must be using VLANs and have CONFIG_PREEMPT enabled.
It is fixed in current sources.

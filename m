Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbULZKct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbULZKct (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 05:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbULZKct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 05:32:49 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:61829
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261631AbULZKcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 05:32:41 -0500
Date: Sun, 26 Dec 2004 02:32:00 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
Message-Id: <20041226023200.1bbf594d.davem@davemloft.net>
In-Reply-To: <200412260917.38717.nick@linicks.net>
References: <200412260917.38717.nick@linicks.net>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004 09:17:38 +0000
Nick Warne <nick@linicks.net> wrote:

> Breaks the build.
> 
> Line 161
> 
> /* Call setsockopt() */
> int nf_setsockopt(struct sock *sk, int pf, int optval, char __user *opt,
>                   int len(;  <-------

That doesn't exist in the 2.6.10 sources.  Something is
up with the source tree you have.  Lots of people would
be complaining if this simplistic error were actually
in the real 2.6.10 tree.

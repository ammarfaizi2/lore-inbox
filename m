Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUCNReI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUCNReI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 12:34:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261457AbUCNReF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 12:34:05 -0500
Date: Sun, 14 Mar 2004 09:33:58 -0800
From: "David S. Miller" <davem@redhat.com>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network/performance problem
Message-Id: <20040314093358.26147c5f.davem@redhat.com>
In-Reply-To: <20040314132339.GA27540@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu>
	<20040311151559.72706624.akpm@osdl.org>
	<20040311233525.GA14065@mtholyoke.edu>
	<20040312164704.GA17969@mtholyoke.edu>
	<20040312225606.GA19722@mtholyoke.edu>
	<20040313223349.3dcbfb61.davem@redhat.com>
	<20040314132339.GA27540@mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004 08:23:40 -0500
Ron Peterson <rpeterso@mtholyoke.edu> wrote:

> Don't think so.  If I revert to 2.4.20 from 2.4.21, and change nothing
> else, this problem goes away.

That's right because a netfilter change during that time period
makes certain auto-rule adding setups go berzerk and it's a bug
in the netfilter userland bits not the kernel.

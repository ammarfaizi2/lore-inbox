Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUIMWto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUIMWto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUIMWtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:49:42 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:30631
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269020AbUIMWta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:49:30 -0400
Date: Mon, 13 Sep 2004 15:47:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5 bug in tcp_recvmsg?
Message-Id: <20040913154742.5dd6dabf.davem@davemloft.net>
In-Reply-To: <200409131544.07365.jbarnes@engr.sgi.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<200409131456.31265.jbarnes@engr.sgi.com>
	<20040913153620.77175c0e.davem@davemloft.net>
	<200409131544.07365.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 15:44:07 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> Nope, VLAN isn't set:
> [jbarnes@tomahawk linux-2.6.9-rc1-mm5]$ grep VLAN .config
> # CONFIG_VLAN_8021Q is not set

Hmmm, then that's a really strange backtrace.  What networking
driver are you using?

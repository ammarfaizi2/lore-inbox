Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbUBZUTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbUBZUSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:18:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262971AbUBZUOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:14:18 -0500
Date: Thu, 26 Feb 2004 12:14:15 -0800
From: "David S. Miller" <davem@redhat.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6: net/core.c should export sysctl_optmem_max for modular
 IPV6
Message-Id: <20040226121415.4836150a.davem@redhat.com>
In-Reply-To: <20040226015907.GA10986@merlin.emma.line.org>
References: <20040226015907.GA10986@merlin.emma.line.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 02:59:07 +0100
Matthias Andree <matthias.andree@gmx.de> wrote:

> IPv6 built as a module fails (in 2.6 BitKeeper tree) because it cannot
> link to sysctl_optmem_max, trivial patch:

Applied, thanks Matthias.
(2.4.x is going to need this too so I added your change there too)

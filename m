Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUA2XkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266493AbUA2XkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:40:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20938 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266496AbUA2XkA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:40:00 -0500
Date: Thu, 29 Jan 2004 15:39:53 -0800
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: kas@informatics.muni.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Patch: IPv6/AMD64: bug in net/ipv6/ndisc.c
Message-Id: <20040129153953.3dd2cd23.davem@redhat.com>
In-Reply-To: <20040130.083743.20740540.yoshfuji@linux-ipv6.org>
References: <20040129221538.J24747@fi.muni.cz>
	<20040130.083743.20740540.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004 08:37:43 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> For long term solution, I think it is better to store timing variables 
> in "unsinged long" type instead of int. 

I think this is the only fix to even consider, even in the short term.
The macro suggested is just too much of a hack. :)

We can just ignore the silly warning until we are able to find time
to do the correct fix.

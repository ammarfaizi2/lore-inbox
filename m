Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUIWVIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUIWVIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUIWVIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:08:18 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:60569
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266170AbUIWVDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:03:11 -0400
Date: Thu, 23 Sep 2004 14:01:58 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: yoshfuji@linux-ipv6.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ArcNet and 2.6.8.1
Message-Id: <20040923140158.4039a39a.davem@davemloft.net>
In-Reply-To: <Pine.OSF.4.05.10409232258030.21511-100000@da410.ifa.au.dk>
References: <20040924.001627.113803491.yoshfuji@linux-ipv6.org>
	<Pine.OSF.4.05.10409232258030.21511-100000@da410.ifa.au.dk>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 22:59:58 +0200 (METDST)
Esben Nielsen <simlo@phys.au.dk> wrote:

> After I got the arcnet device running labtop computer froze up. I have
> turned off preemtion and SMP. It seems to make it more stable but I can't
> be conclusive.

Based upon the fact that most Arcnet drivers set hw.open() to NULL,
and you're the first person to report this, I doubt arcnet is
getting any serious use or testing at all these days.  Sorry :-/

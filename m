Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSHLKWP>; Mon, 12 Aug 2002 06:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSHLKWO>; Mon, 12 Aug 2002 06:22:14 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41976 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317755AbSHLKWO>; Mon, 12 Aug 2002 06:22:14 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       julliard@winehq.com, ldb@ldb.ods.org
In-Reply-To: <Pine.LNX.4.44.0208121415550.4996-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121415550.4996-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 12:47:17 +0100
Message-Id: <1029152837.16424.157.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 13:17, Ingo Molnar wrote:
> ugh, we do Linux interrupts while in the APM BIOS?

We have to. Most APM bios expects interrupts to be happening. In
pre-emptive mode we may well even be switching to/from APM BIOS code in
2.5 at the moment. I've not looked into that.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVDEIFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVDEIFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVDEH66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:58:58 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:3482
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261619AbVDEHo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:44:59 -0400
Date: Tue, 5 Apr 2005 00:43:46 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Fix get_compat_sigevent()
Message-Id: <20050405004346.17b39bd1.davem@davemloft.net>
In-Reply-To: <20050405173724.120631d7.sfr@canb.auug.org.au>
References: <20050404224409.1a34e732.davem@davemloft.net>
	<20050405173724.120631d7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005 17:37:24 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Mon, 4 Apr 2005 22:44:09 -0700 "David S. Miller" <davem@davemloft.net> wrote:
> >
> > I have no idea how a bug like this lasted so long.
> 
> Probably because very few programs pass sigevents into the kernel ...

Perhaps, but this triggered an OOPS the first time I tried to
run the glibc testsuite on a compat platform.

Something for the LTP folks to add I guess.  :) I do run that all
the time.

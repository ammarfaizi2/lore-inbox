Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269073AbUINAXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269073AbUINAXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUINAXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:23:06 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:49320
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269073AbUINAW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:22:59 -0400
Date: Mon, 13 Sep 2004 17:21:06 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5 bug in tcp_recvmsg?
Message-Id: <20040913172106.44f0a3b8.davem@davemloft.net>
In-Reply-To: <200409131703.48395.jbarnes@engr.sgi.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<200409131654.27727.jbarnes@engr.sgi.com>
	<20040913165557.568cdffb.davem@davemloft.net>
	<200409131703.48395.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 17:03:48 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Monday, September 13, 2004 4:55 pm, David S. Miller wrote:
> > On Mon, 13 Sep 2004 16:54:27 -0700
> >
> > Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > tg3.  I saw one trace that included do_poll (iirc) and another last week
> > > that had sys_select in it.  I'll try to gather some more info.
> >
> > What you're seeing might be due to the bug fixed by this patch:
 ..
> Ok, I guess that would explain why I haven't seen this in 2.6.9-rc2.  I was 
> getting my backtraces confused too--I've only seen this one for this bug.  
> I'll keep an eye out and report anything I see with the latest bk tree.

The patch isn't in the tree yet, you would see the problem in
2.6.9-rc2

Please try to get a clean backtrace with a current tree plus
the patch I posted, and I'll scratch my head some more.
:-)

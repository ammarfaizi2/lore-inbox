Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbTC3ByG>; Sat, 29 Mar 2003 20:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263369AbTC3ByG>; Sat, 29 Mar 2003 20:54:06 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:61454
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263357AbTC3ByF>; Sat, 29 Mar 2003 20:54:05 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Robert Love <rml@tech9.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1048987260.679.7.camel@teapot>
References: <3E8610EA.8080309@telia.com>
	 <1048980204.13757.17.camel@localhost>  <1048987260.679.7.camel@teapot>
Content-Type: text/plain
Organization: 
Message-Id: <1048989922.13757.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 21:05:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 20:21, Felipe Alfaro Solana wrote:

> Theoretically, with interactivity enhancaments, you'll never need to
> renice X. In fact, I'm running X with no renice and it feels pretty
> snappy.

I know.

I was wondering, since we are working on an actual bug here, whether or
not renicing X is leading to a starvation issue between X and whatever
is starving.  I have seen it before.

My system is responsive, too, and I do not renice X.  But it might
help.  Or it might cause starvation issues.  We have a bug somewhere...

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTFLRgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbTFLRgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:36:40 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:33160 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264925AbTFLRfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:35:53 -0400
Date: Thu, 12 Jun 2003 10:50:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbadari@us.ibm.com
Subject: Re: 2.5.70-mm6
Message-Id: <20030612105041.3e0320a7.akpm@digeo.com>
In-Reply-To: <1055435864.1466.9.camel@w-ming2.beaverton.ibm.com>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<3EE690AC.70500@us.ibm.com>
	<20030610201242.7fde819b.akpm@digeo.com>
	<1055435864.1466.9.camel@w-ming2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 17:49:38.0883 (UTC) FILETIME=[FEAF2130:01C3310A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> 
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > >
> > > I run 50 fsx tests on ext3 filesystem on 2.5.70-mm6 kernel. Serveral fsx 
> > >  tests hang with the status D, after the tests run for a while.  No oops, 
> > >  no error messages.  I found same problem on mm5, but 2.5.70 is fine.
>
> Sorry, the tests in 2.5.70 also failed, same problem.

OK.  It would be useful to test ext2 as well.

> On Tue, 2003-06-10 at 20:12, Andrew Morton wrote
> > If you could, please retest with "elevator=deadline"?
> > 
> Thanks for your feedback.
> 
> This time I got more fsx tests hang(about 25).  Before normally I saw 5
> or 10 tests fail. Here is the stack info.

Everything stuck waiting for IO to complete again.

Are you able to try a different qlogic driver?  Or a different HBA?

I tried to reproduce this but I don't have sufficient info.

How much memory does that machine have, and what fsx-linux command lines
are you using?

Thanks.


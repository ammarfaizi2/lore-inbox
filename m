Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319122AbSHTAhW>; Mon, 19 Aug 2002 20:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319123AbSHTAhW>; Mon, 19 Aug 2002 20:37:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45561 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319122AbSHTAhW>; Mon, 19 Aug 2002 20:37:22 -0400
Subject: Re: MAX_PID changes in 2.5.31
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020820003346.GA4592@win.tue.nl>
References: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
	<1029799751.21212.0.camel@irongate.swansea.linux.org.uk> 
	<20020820003346.GA4592@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 01:41:32 +0100
Message-Id: <1029804092.21242.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-20 at 01:33, Andries Brouwer wrote:
> On Tue, Aug 20, 2002 at 12:29:11AM +0100, Alan Cox wrote:
> 
> > libc5 is very much 16bit pid throughout.
> 
> Can you clarify?

It uses the 16bit assuming syscall entry points, and has no knowledge of
the 32bit pid stuff when its needed


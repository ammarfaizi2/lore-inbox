Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267061AbSIRPmk>; Wed, 18 Sep 2002 11:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267063AbSIRPmk>; Wed, 18 Sep 2002 11:42:40 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:4092 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267061AbSIRPmk>; Wed, 18 Sep 2002 11:42:40 -0400
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
	elimination, 2.5.35-BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cort Dougan <cort@fsmlabs.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020918090104.E14918@host110.fsmlabs.com>
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain>
	<20020918123206.GA14595@win.tue.nl> <20020918144939.GU3530@holomorphy.com> 
	<20020918090104.E14918@host110.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 16:50:46 +0100
Message-Id: <1032364246.20498.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 16:01, Cort Dougan wrote:
> Can we get a lockless, scalable, fault-tolerant, pre-emption safe,
> zero-copy and distributed get_pid() that meets the Carrier Grade
> specification?  If at all possible I need it to do garbage collection, too.

I did one, but it garbage collected and there was nothing left 8)


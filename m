Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130368AbRA3OcY>; Tue, 30 Jan 2001 09:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbRA3OcO>; Tue, 30 Jan 2001 09:32:14 -0500
Received: from helena.mi.uni-erlangen.de ([131.188.103.20]:44436 "EHLO
	mi.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S130368AbRA3OcA>; Tue, 30 Jan 2001 09:32:00 -0500
Date: Tue, 30 Jan 2001 15:31:30 +0100 (MET)
From: Walter Hofmann <snwahofm@mi.uni-erlangen.de>
To: Antonio Miguel Trindade <trindade@dei.uc.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: RTC hardware clock option
In-Reply-To: <01013014004308.23105@polaris>
Message-ID: <Pine.GSO.3.96.1010130152855.1494A-100000@charybdis>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jan 2001, Antonio Miguel Trindade wrote:

> I just would like to ask all of you what has the option "RTC stores time in 
> GMT" have to do with APM... The hardware clock in my machine stores time in 
> GMT, but I do not want APM, so why do I have to have APM just to have that 
> option enabled...
> 
> Perhaps the intention is to remove that depency, but it has not been done out 
> of lazyness... (no pun intended, Linus).

There is no dependency: APM needs to know this to restore the clock after
returning from stand-by.

Without APM there is no need to know this (for the kernel). You can still
run your hardware clock with GMT.

Walter

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

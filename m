Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSE0RvN>; Mon, 27 May 2002 13:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSE0RvM>; Mon, 27 May 2002 13:51:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56303 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316715AbSE0RvL>; Mon, 27 May 2002 13:51:11 -0400
Subject: Re: interrupt latency/700microsecs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muthal Sangam <sangam@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17CNNm-000GQe-00@f11.mail.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 19:53:46 +0100
Message-Id: <1022525626.11859.307.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 17:30, Muthal Sangam wrote:
> On kernel 2.4.7, AMDK6 @ 450MHz processor, is it possible to get latency
> fluctuations of upto 700microsecs for running the timer interrupt, due to
> interrupts being disabled ?
> 
> I am using the time stamp counter and reading it at the start of the timer
> interrupt and measuring the cycles elapsed between two inovocations of it.
> The number of cycles elapsed is ~4500225, but sometimes it increases to as
> high as 4848032. Can i conclude that this difference is due to interrupts
> being disabled in critical sections ? ( I think i am making some mistake :-)

In X with a matrox G200 I've observed processor stalls in excess of 1mS
so Im not actually much suprised.



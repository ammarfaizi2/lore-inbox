Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSHaQkD>; Sat, 31 Aug 2002 12:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317755AbSHaQkD>; Sat, 31 Aug 2002 12:40:03 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:6388 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317752AbSHaQkD>; Sat, 31 Aug 2002 12:40:03 -0400
Subject: Re: i810_audio problems + patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick McHardy <kaber@the.brain.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208311757120.24208-200000@the.brain.uni-freiburg.de>
References: <Pine.LNX.4.44.0208311757120.24208-200000@the.brain.uni-freiburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 17:44:22 +0100
Message-Id: <1030812262.3490.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-31 at 17:09, Patrick McHardy wrote:
> somewhere between 2.4.18 and 2.4.19 i810_audio.c was changed to exclude
> softmodems from initilization. Since then, i cannot use the mixer anymore
> and also 44.1khz rates don't work anymore. Reverting the change made these
> things work again.

Reverting the change is not the right answer. I need to find out why
your codec thinks its a modem when its clearly not.


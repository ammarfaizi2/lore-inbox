Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbTCZNNV>; Wed, 26 Mar 2003 08:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261682AbTCZNNV>; Wed, 26 Mar 2003 08:13:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34231
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261680AbTCZNNU>; Wed, 26 Mar 2003 08:13:20 -0500
Subject: Re: System time warping around real time problem - please help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: george anzinger <george@mvista.com>
Cc: Fionn Behrens <fionn@unix-ag.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E811055.5040202@mvista.com>
References: <1048609931.1601.49.camel@rtfm>
	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>
	 <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm>
	 <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
	 <3E811055.5040202@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048689492.31839.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 14:38:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 02:28, george anzinger wrote:
> Stands for Time Stamp Counter.  It is a special cpu register that 
> basically counts cpu cycles.  Some times (incorrectly me thinks) it is 
> affected by power management code which slows the cpu by changing the 
> cpu frequency.

Not incorrectly. It counts cpu clocks, its designed for profiling and
the like. There is no guarantee in any Intel MP standard that the clocks
are synched up.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275263AbRIZPeb>; Wed, 26 Sep 2001 11:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275275AbRIZPeV>; Wed, 26 Sep 2001 11:34:21 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:42971 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S275263AbRIZPeF>; Wed, 26 Sep 2001 11:34:05 -0400
Date: Wed, 26 Sep 2001 17:34:21 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Cc: "Manfred H. Winter" <mahowi@gmx.net>
Subject: Re: PROBLEM: 2.4.10: ifconfig gets signal 17
Message-ID: <20010926173421.A9474@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20010925193458.A592@marvin.mahowi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010925193458.A592@marvin.mahowi.de>
User-Agent: Mutt/1.3.22i
X-Operating-System: vega Linux 2.4.10-grsecurity-1.8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 07:34:58PM +0200, Manfred H. Winter wrote:
> [1.] One line summary of the problem:
>      
> 	 2.4.10: ifconfig gets signal 17
> 
> [2.] Full description of the problem/report:
>      
> 	 After updating from kernel 2.4.9 to 2.4.10 I get the following
>      error after booting:
> 
> 	 task `ifconfig' exit_signal 17 in reparent_to_init
> 	 Sep 25 19:07:58 marvin kernel: task `ifconfig' exit_signal 17 in
> 	 reparent_to_init

The same here. However I've just discovered a workaround for this problem:

The NIC and my SB Live! soundcard shares the same IRQ. If I tried to configure
the NIC before the soundcard I got the message I've described. But if I
configured soundcard first and then NIC, it worked without any problem.
However it's only a workaround and this problem should be fixed. IMHO.

- Gabor

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----

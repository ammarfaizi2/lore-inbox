Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135608AbREIAij>; Tue, 8 May 2001 20:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135611AbREIAia>; Tue, 8 May 2001 20:38:30 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:4045 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135608AbREIAiS>; Tue, 8 May 2001 20:38:18 -0400
Message-ID: <3AF890F9.A414620@uow.edu.au>
Date: Wed, 09 May 2001 10:36:09 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <Pine.LNX.3.95.1010508154726.29540A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> To driver wizards:
> 
> I have a driver which needs to wait for some hardware.
> Basically, it needs to have some code added to the run-queue
> so it can get some CPU time even though it's not being called.
> 
> It needs to get some CPU time which can be "turned on" or
> "turned off" as a result of an interrupt or some external
> input from  an ioctl().

schedule_task()?

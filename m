Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274855AbRIUW0E>; Fri, 21 Sep 2001 18:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274858AbRIUWZy>; Fri, 21 Sep 2001 18:25:54 -0400
Received: from pop.timesn.com ([216.30.51.65]:38911 "EHLO srvaus02.timesn.com")
	by vger.kernel.org with ESMTP id <S274855AbRIUWZl>;
	Fri, 21 Sep 2001 18:25:41 -0400
Message-ID: <3BABC1D9.CCA61963@timesn.com>
Date: Fri, 21 Sep 2001 17:40:25 -0500
From: Ray Bryant <raybry@timesn.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AIC-7XXX driver problems with 2.4.9 and L440GX+
In-Reply-To: <200109212100.f8LL08Y61889@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a note about a bugzilla comment written by Doug Ledford at
RedHat at
http://www.cs.helsinki.fi/linux/linux-kernel/2001-18/0508.html
that suggests a work around is to build the kernel with IO-APIC support.
This appears to fix the current problem.  So unless something else comes
up,
I am "fixed" at the moment.  

"Justin T. Gibbs" wrote:
> 
> >The AIC-7XXX version 6.2.1 driver hangs at startup under 2.4.x  (we've
> >tried 2.4.2-2 (RH 7.1), 2.4.5, and 2.4.9).
> >The complete boot output is attached; the interesting parts are
> >as follows:
> 
> This again looks like an interrupt problem (driver not seeing interrupts).
> To know for sure, I'd need to see the messages from an "aic7xxx=verbose"
> boot.
> 
> --
> Justin

-- 
----------------------------------------------------------- 
  Ray Bryant,  Linux Performance Analyst, Times N Systems
   1908 Kramer Lane, Bldg. B, Suite P, Austin, TX 78758
              512-977-5366, raybry@timesn.com
-----------------------------------------------------------

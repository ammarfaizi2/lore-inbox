Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbRFVBgY>; Thu, 21 Jun 2001 21:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265307AbRFVBgO>; Thu, 21 Jun 2001 21:36:14 -0400
Received: from w115.z208177135.sjc-ca.dsl.cnc.net ([208.177.135.115]:4235 "EHLO
	technolunatic.com") by vger.kernel.org with ESMTP
	id <S265306AbRFVBgJ>; Thu, 21 Jun 2001 21:36:09 -0400
Date: Thu, 21 Jun 2001 18:36:03 -0700
From: Dionysius Wilson Almeida <dwilson@technolunatic.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout
Message-ID: <20010621183603.A28081@technolunatic.com>
Reply-To: dwilson@technologist.com
In-Reply-To: <20010620163134.A22173@technolunatic.com> <20010620195134.A6877@saw.sw.com.sg> <20010620170202.B22565@technolunatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010620170202.B22565@technolunatic.com>; from dwilson@technolunatic.com on Wed, Jun 20, 2001 at 05:02:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried inserting a udelay(1) and increasing the count ..but
the same behaviour.  

any clues ? btw, i've been able to compile the redhat 7.1 intel e100
driver and it works fine for my card.

-Wilson

* Dionysius Wilson Almeida (dwilson@technolunatic.com) wrote:
> No..that was pretty much what i saw in the logs.
> 
> I see wait_for_cmd_done timeout being the only one being repeated in the
> logs
> 
> -Wilson
> `
> * Andrey Savochkin (saw@saw.sw.com.sg) wrote:
> > What was the first error message from the driver?
> > NETDEV WATCHDOG report went before wait_for_cmd_done timeout and is more
> > important.  I wonder if you had some other messages before the watchdog one.
> > 
> > 	Andrey
> > 
> > On Wed, Jun 20, 2001 at 04:31:34PM -0700, Dionysius Wilson Almeida wrote:
> > > And this is the log when the card hangs :
> > > =========================================
> > > Jun 20 16:10:18 debianlap kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > > Jun 20 16:10:18 debianlap kernel: eth0: Transmit timed out: status 0050  0c80 at 314/342 command 000c0000.
> > > Jun 20 16:10:18 debianlap kernel: eth0: Tx ring dump,  Tx queue 342 / 314:
> > > Jun 20 16:14:07 debianlap kernel: eepro100: wait_for_cmd_done timeout!
> > > Jun 20 16:14:38 debianlap last message repeated 5 times
> 
> -- 
> Eat shit -- billions of flies can't be wrong.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Fortune's Office Door Sign of the Week:

	Incorrigible punster -- Do not incorrige.

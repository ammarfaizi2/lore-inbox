Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSANNKR>; Mon, 14 Jan 2002 08:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289228AbSANNKH>; Mon, 14 Jan 2002 08:10:07 -0500
Received: from mail007.syd.optusnet.com.au ([203.2.75.231]:46533 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S289226AbSANNJ5>; Mon, 14 Jan 2002 08:09:57 -0500
Subject: Re: PROBLEM: System locks up after "spurious 8259A interrupt: IRQ7"
From: Antony Suter <antonysuter@optusnet.com.au>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E16Q2TD-0005Gl-00@antoli.uib.es>
In-Reply-To: <E16Q2TD-0005Gl-00@antoli.uib.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Jan 2002 00:08:03 +1100
Message-Id: <1011013691.5219.17.camel@gestalt.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 19:27, Ricardo Galli wrote:
> > sporadically my machine hangs (no response to keyboard, can't connect
> > via network, no interaction via remote-control) and the last thing I
> > see (if I see anything at all) is something like
> >
> >
> > --- snip ---
> > [...]
> > Jan 13 21:30:00 atlan CROND[2876]: (till) CMD (fetchmail&> /dev/null)
> > Jan 13 21:30:09 atlan kernel: spurious 8259A interrupt: IRQ7.
> 
> I am having the same problem since several versions ago:
> 
> Jan 13 15:15:48 antoli kernel: spurious 8259A interrupt: IRQ7.
> 
> It always happens when X is started on the kernel tainted with the nvidia 
> module. But never gave any problem at all.
> 
> I've never reported it due the tainted version. But it seems it's not 
> directly related to nvidia driver nor the hardware.
> 
> I have an ASUS/Intel815 motherboard (BTW, the 8259A is the Intel programmable 
> interrupt controller).

Ive gotten the same message in my logs since Dec 30th. The very same day
I switched to Mandrake 8.1, with NVIDIAs latest drivers (2313) on a ASUS
Geforce 3 card. (Athlon 1.2GHz tbird, 512 MB RAM, ASUS A7V133 mobo with
raid chip).

I dont get a lockup though.

Ive had that message at the console a few times when X isnt running.
Doesnt seem to occur when X is running though.

-- 
- Antony Suter  (antonysuter@optusnet.com.au)  "Examiner" 
openpgp:7916EE67
- "Savahnah River. K Reactor. 1968. It was a very good year."


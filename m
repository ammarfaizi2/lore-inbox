Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286951AbRL1Rqa>; Fri, 28 Dec 2001 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286953AbRL1RqU>; Fri, 28 Dec 2001 12:46:20 -0500
Received: from nta-monitor.demon.co.uk ([212.229.78.70]:25097 "EHLO
	mercury.nta-monitor.com") by vger.kernel.org with ESMTP
	id <S286938AbRL1Rpj>; Fri, 28 Dec 2001 12:45:39 -0500
Message-Id: <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
Date: Fri, 28 Dec 2001 17:44:10 +0000
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
        linux-kernel@vger.kernel.org
From: Roy Hills <linux-kernel-l@nta-monitor.com>
Subject: Re: zImage not supported for 2.2.20?
In-Reply-To: <20011228163250.A31791@elektroni.ee.tut.fi>
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
 <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1>
 <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1>
 <20011228121228.GA9920@emma1.emma.line.org>
 <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:32 28/12/01 +0200, Petri Kaukasoina wrote:
>Hi, I used to make zImages, but for no specific reason. The last working
>version was 2.2.20pre3. 2.2.20pre5 gave Out of memory -- System halted. I
>reported it a few months ago:
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.2/0363.html
>
>This was the only change then that looks like it:
>
>o       Add support for the 2.4 boot extensions to 2.2  (H Peter Anvin)

So it looks like this is a real issue, and it's been tracked down to somewhere
between 2.2.20pre3 and 2.2.20pre5.

Unfortunately, I need to use zImage on my Tecra.  I know that zImage is
old, and I've heard that support for it will eventually be withdrawn, but I
don't really have much alternative right now unless there is a patch which
works around the Tecra's buggy A20 handling.

Does anyone know the status of zImage format in modern kernels?
Is it _supposed_ to be supported under 2.2.recent?  How about 2.4.recent?

I guess that, if zImage is supposed to be supported, then I have a genuine
bug.  However, if zImage support has officially been dropped, then it's a 
different
matter - in this case, the only bug would be that the Makefile should issue a
sensible message when you try to "make zImage" rather than producing a kernel
that won't work.

Regards,

Roy Hills

--
Roy Hills                                    Tel:   +44 1634 721855
NTA Monitor Ltd                              FAX:   +44 1634 721844
14 Ashford House, Beaufort Court,
Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/


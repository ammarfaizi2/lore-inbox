Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286923AbRL1OdK>; Fri, 28 Dec 2001 09:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286922AbRL1OdB>; Fri, 28 Dec 2001 09:33:01 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:38418 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S286920AbRL1Ocw>; Fri, 28 Dec 2001 09:32:52 -0500
Date: Fri, 28 Dec 2001 16:32:50 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
Message-ID: <20011228163250.A31791@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <20011228121228.GA9920@emma1.emma.line.org> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>; from linux-kernel-l@nta-monitor.com on Fri, Dec 28, 2001 at 01:11:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 01:11:42PM +0000, Roy Hills wrote:
> The old 2.2.17 zImage kernel that runs fine has a filesize of 462060 bytes and
> reports 784k kernel code, 412k reserved, 1168k data, 36k init.
> 
> The new 2.2.20 zImage kernel that fails has a filesize of 482795 bytes.
> Note that the actual problem with Toshiba tecra laptops and bzImage files is
> a known hardware problem (something to do with the A20 line).  I'm not trying
> to address this problem, just why the normal workaround (use zImage rather
> than bzImage to keep in conventional memory) doesn't work any more with
> 2.2.20.

Hi, I used to make zImages, but for no specific reason. The last working
version was 2.2.20pre3. 2.2.20pre5 gave Out of memory -- System halted. I
reported it a few months ago:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.2/0363.html

This was the only change then that looks like it:

o       Add support for the 2.4 boot extensions to 2.2  (H Peter Anvin)

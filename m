Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279720AbRJ3BVI>; Mon, 29 Oct 2001 20:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279716AbRJ3BU7>; Mon, 29 Oct 2001 20:20:59 -0500
Received: from codepoet.org ([166.70.14.212]:43350 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S279715AbRJ3BUx>;
	Mon, 29 Oct 2001 20:20:53 -0500
Date: Mon, 29 Oct 2001 18:21:32 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: r128 + agpgart + APM suspend = death
Message-ID: <20011029182132.A13066@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011028212006.A9278@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011028212006.A9278@codepoet.org>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Oct 28, 2001 at 09:20:06PM -0700, Erik Andersen wrote:
> I have a Dell Latitude C800 laptop.  It works just great and
> I can use agpgart + r128 + XFree86 4.0.1 to get nice full 
> screen 3D.  tuxracer looks nice.
> 
> But if I suspend my laptop when the agpgart module is loaded
> is seems to suspend just fine, but will not resume....  Just
[----------snip---------------]
> 
> Anyone else seeing similar problems with APM + agpgart?
> The problem has has been the same with all the 2.4.x kernels
> I've tried it on, though I am running 2.4.12-ac6 at the moment.

One more bit of data.  XFree86 reports that my system has a:
    (--) PCI:*(1:0:0) ATI Rage 128 Mobility MF rev 0, Mem @ 0xe8000000/26, 0xfcffc000/14, I/O @ 0xcc00/8

A few friends of mine have similar Dell laptops with the same set of kernel
modules loaded -- and theirs do not choke on APM suspend.  But their systems 
report a slightly different r128 model: 
    (--) PCI:*(1:0:0) ATI Rage 128 Mobility LF rev 2, Mem @ 0xf8000000/26, 0xf4100000/14, I/O @ 0x2000/8

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

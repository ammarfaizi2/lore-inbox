Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278694AbRJ3XJe>; Tue, 30 Oct 2001 18:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278712AbRJ3XJS>; Tue, 30 Oct 2001 18:09:18 -0500
Received: from ool-18b95509.dyn.optonline.net ([24.185.85.9]:48770 "EHLO
	lfmobile.lmc.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id <S278694AbRJ3XJA>; Tue, 30 Oct 2001 18:09:00 -0500
To: andersen@codepoet.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: r128 + agpgart + APM suspend = death
In-Reply-To: <20011028212006.A9278@codepoet.org>
	<20011029182132.A13066@codepoet.org>
From: Luis Fernando Pias de Castro <luis@cs.sunysb.edu>
In-Reply-To: <20011029182132.A13066@codepoet.org>
Date: 30 Oct 2001 18:05:59 -0500
Message-ID: <87g0807mp4.fsf@lfmobile.lmc.cs.sunysb.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

my machine prints the same message, but your mail prompted me to
update my bios (from A10 to A17), and now I can suspend and resume w/
agpgart loaded. Using 2.4.12-ac5 and XFree 4.1.0

HTH,
-Luis

Erik Andersen <andersen@codepoet.org> writes:

> On Sun Oct 28, 2001 at 09:20:06PM -0700, Erik Andersen wrote:
> > I have a Dell Latitude C800 laptop.  It works just great and
> > I can use agpgart + r128 + XFree86 4.0.1 to get nice full 
> > screen 3D.  tuxracer looks nice.
> > 
> > But if I suspend my laptop when the agpgart module is loaded
> > is seems to suspend just fine, but will not resume....  Just
> [----------snip---------------]
> > 
> > Anyone else seeing similar problems with APM + agpgart?
> > The problem has has been the same with all the 2.4.x kernels
> > I've tried it on, though I am running 2.4.12-ac6 at the moment.
> 
> One more bit of data.  XFree86 reports that my system has a:
>     (--) PCI:*(1:0:0) ATI Rage 128 Mobility MF rev 0, Mem @ 0xe8000000/26, 0xfcffc000/14, I/O @ 0xcc00/8
> 
> A few friends of mine have similar Dell laptops with the same set of kernel
> modules loaded -- and theirs do not choke on APM suspend.  But their systems 
> report a slightly different r128 model: 
>     (--) PCI:*(1:0:0) ATI Rage 128 Mobility LF rev 2, Mem @ 0xf8000000/26, 0xf4100000/14, I/O @ 0x2000/8
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

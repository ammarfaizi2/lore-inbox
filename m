Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289479AbSAOKF7>; Tue, 15 Jan 2002 05:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289476AbSAOKFp>; Tue, 15 Jan 2002 05:05:45 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:61857 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289473AbSAOKF3>; Tue, 15 Jan 2002 05:05:29 -0500
Message-Id: <200201151005.g0FA5LgB002726@tigger.cs.uni-dortmund.de>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Mon, 14 Jan 2002 12:52:28 EST." <20020114125228.B14747@thyrsus.com> 
Date: Tue, 15 Jan 2002 11:05:21 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> Eli Carter <eli.carter@inet.com>:
> > Could you maybe describe the problem you are trying to solve a bit more
> > clearly than "the hardware-discovery problem for ISA devices"?  If you
> > are trying to discover the ISA devices, but rely upon them having
> > already been discovered, what are you accomplishing?

> Sure.  Let's say Aunt Tillie needs a kernel update.

So Aunt Tillie goes and clicks on "Update distribution", which gets her Red
Hat's up2date or Debian's apt-get or whatever. A reboot later she is happy.

All the nonsense about "faster kernel for K6" and "Nephew Melvin" is just
nonsense. Please do remember the horrors of some of the "latest stable"
kernels, and think thrice before you inflict same on poor Aunt Tillie.

If she wants a kernel for her machine "latest revision", give her a
.configure that builds a fully modular kernel distribution style.

Sure, it would be _way_ cool to have your autodetection stuff. Just:

- ISA is impossible to do right. And on the way out, so irrelevant.
- PCI is rather easy.
- PCMCIA, USB, ... are on the rise. How is your autoconfigurator to detect
  the USB Zip drive Nephew Melvin carries around and uses to backup Aunties
  account from time to time? Or the PCMCIA network card Aunt Tillie is
  keeping in the top drawer for a rainy day? Or the CD burner she plans to
  buy tomorrow?

What would she gain? A smaller kernel (mostly irrelevant, Aunt Tillie sure
hasn't got an 8MB RAM machine), less modules on disk (what, you are
worrying about a few MB on a multi-GB disk?)

As I said before, you are trying to solve a non-problem.

In any case, it's your time. Good luck!
-- 
Horst von Brand			     http://counter.li.org # 22616

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281787AbRK1GSw>; Wed, 28 Nov 2001 01:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281591AbRK1GSn>; Wed, 28 Nov 2001 01:18:43 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:27796 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S281777AbRK1GSe>;
	Wed, 28 Nov 2001 01:18:34 -0500
Message-ID: <XFMail.20011128071832.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20011127180622.B1087@wonko.esi.org.pl>
Date: Wed, 28 Nov 2001 07:18:32 +0100 (CET)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
Subject: Re: 2.4.12 ... 2.4.16, /dev/tty
Cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dominik,

On 27-Nov-2001 Dominik Mierzejewski wrote: 
>  On Tuesday, 27 November 2001, Yaroslav Popovitch wrote:
> > 
> > 
> > I also tested my 2.4.10-17 for tty bug,it was there.And I found that bug
> > exists if I do the full installation of our distributive.
> > 
> > > Hi,
> > > 
> > > still having problems (starting with kernel 2.4.12) with
> > > the /dev/tty device:
> > > 
> > > When logging in on the console and trying the "ps" command,
> > > is will list  _all_ processes and not only those which are
> > > attached to the controlling terminal. This seemed a little
> > > bit suspicious.
>  [snip] 
> > > -----------------------------------------------------
> > > 
> > > The above described problem first appeared with Kernel 2.4.12,
> > > I tried the following kernels (now 2.4.16), BUT WITH NO SUCCESS.
> > > Kernel 2.4.10 was _not buggy_.
> > > 
> > > Additionally, the problem does not arise on all my LINUX workstations,
> > > but only on some. And it does not depend on the harware platform.
> > > And is does not depend on the distribution. Both on RedHat 7.1 ans
> > > Redhat 7.2 having the problem.
>  
>  I believe it's a problem with /bin/login, which has a race condition
>  preventing it from opening /dev/tty. It is fixed in rawhide, upgrading
>  util-linux to at least 2.11f-6 solved this for me.
>  So it's not a kernel issue.

Thanks, this helped me a lot. Only one issue: after installing rawhide vers. 2.11f-16
of util-linux and not 2.11f-6, my problem disappeared.

Regards

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  


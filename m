Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285160AbRLFOpw>; Thu, 6 Dec 2001 09:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285163AbRLFOpm>; Thu, 6 Dec 2001 09:45:42 -0500
Received: from web13904.mail.yahoo.com ([216.136.175.67]:64777 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285160AbRLFOpc>; Thu, 6 Dec 2001 09:45:32 -0500
Message-ID: <20011206144530.83780.qmail@web13904.mail.yahoo.com>
Date: Thu, 6 Dec 2001 06:45:30 -0800 (PST)
From: Jorge Carminati <jcarminati@yahoo.com>
Subject: Re: Kernel freezing....
To: linux-kernel@vger.kernel.org
In-Reply-To: <E16Bzc9-0001pF-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > installed two times Red Hat in this notebook during this week, and
> no
> > freeze was suffered during the whole installation process, which is
> a
> > process that as you know requires almost an hour to complete.
> > 
> > I´m just asking why the kernel doesn´t freeze during the
> installation
> > process (which it is supposed to run Linux I suspect :) ) and just
> > after booting and typing some commands in init 1 mode, it freezes;
> > quite strange. 
> 
> At least one possible cause is that the runtime kernels will use APM
> power
> management and other facilities that the install kernel intentionally
> avoids
> because a tiny number of boxes have it broken.
> 
> You can boot with extra boot options (apm=off I believe it is) to
> disable
> APM use.

Alan,

The custom made kernel (2.4.16) I tried yesterday (compiled under my
Mandrake workstation and ftped to the notebook) didn´t have the APM
option set. I could post the .config but first, as to discard a memory
error as you suggested, I´ll try tonight memtest86 and see what
happends.

Thanks.
jc.


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132582AbRDCTnV>; Tue, 3 Apr 2001 15:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132612AbRDCTnM>; Tue, 3 Apr 2001 15:43:12 -0400
Received: from mail.occamnetworks.com ([216.64.159.194]:63239 "EHLO
	occamnetworks.com") by vger.kernel.org with ESMTP
	id <S132582AbRDCTnH>; Tue, 3 Apr 2001 15:43:07 -0400
Message-ID: <3ACA2761.16F4B63D@occamnetworks.com>
Date: Tue, 03 Apr 2001 12:41:21 -0700
From: Koral Ilgun <koral@occamnetworks.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Passos <lists@cyclades.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux PPP List <linux-ppp@vger.kernel.org>
Subject: Re: MLPPP in kernels 2.2.x w/ PPP v2.4.1
In-Reply-To: <Pine.LNX.4.30.0104031042540.25537-100000@intra.cyclades.com> <3ACA2697.ACC4EDD7@occamnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, I forgot to add the most important part from README.linux:

...
The 2.2 series kernels contain an older version of the kernel PPP
driver, one which doesn't support multilink.  If you want multilink,
you need to run the latest 2.4 series kernel.  The kernel PPP driver
was completely rewritten for the 2.4 series kernels to support
multilink and to allow it to operate over diverse kinds of
communication medium (the 2.2 driver only operates over serial ports
and devices which look like serial ports, such as pseudo-ttys).
...


Koral


Koral Ilgun wrote:
> 
> These are excerpts from ppp 2.4.1 README.linux file:
> 
> ...
> 
> The Linux PPP implementation includes both kernel and user-level
> parts.  This package contains the user-level part, which consists of
> the PPP daemon (pppd) and associated utilities.  In the past this
> package has contained updated kernel drivers.  This is no longer
> necessary, as the current 2.2 and 2.4 kernel sources contain
> up-to-date drivers.
> 
> ...
> 
> 2.1 Kernel driver
> 
> Assuming you are running a recent 2.2 or 2.4 (or later) series kernel,
> the kernel source code will contain an up-to-date kernel PPP driver.
> If the PPP driver was included in your kernel configuration when your
> kernel was built, then you only need to install the user-level
> programs.  Otherwise you will need to get the source tree for your
> kernel version, configure it with PPP included, and recompile.  Most
> Linux distribution vendors ship kernels with PPP included in the
> configuration.
> 
> ...
> 
> Hope this helps,
> 
> Koral
> 
> Ivan Passos wrote:
> >
> > Hello, everyone,
> >
> > The quick question: if I install PPP 2.4.1 in a Linux box w/ kernel 2.2.x,
> > will I have support to MLPPP??
> >
> > Now, the explanation for my doubt. I've seen several (actually 3)
> > different MLPPP implementations for older versions of PPP/pppd (namely
> > 2.3.5 and 2.3.11). I'd like to know if once I install PPP 2.4.1 in a
> > system w/ kernel 2.2.x, I kill my need for these kind of patches in order
> > to support MLPPP. Or would I still need some kind of patch, even for PPP
> > 2.4.1, to have MLPPP support in kernels 2.2.x??
> >
> > I know that for kernels 2.4.x these patches are not needed.
> >
> > Thanks in advance for your help!
> >
> > Later,
> > Ivan
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ppp" in
> > the body of a message to majordomo@vger.kernel.org
> 
> --
> Koral Ilgun
> Software Engineer
> Occam Networks, Inc.

-- 
Koral Ilgun
Software Engineer
Occam Networks, Inc.

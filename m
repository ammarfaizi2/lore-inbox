Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbTJJNjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJJNjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:39:24 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:41415 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262803AbTJJNjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:39:22 -0400
Subject: Re: Linksys/Cisco GPL Violations
From: David Woodhouse <dwmw2@infradead.org>
Reply-To: dwmw2@infradead.org
To: Florian Schirmer <jolt@tuxbox.org>
Cc: linux-kernel@vger.kernel.org, David Turner <novalis@fsf.org>,
       andrew@mikl.as, rob@nocat.net
In-Reply-To: <023501c38f32$2b83caa0$9602010a@jingle>
References: <1064859766.20847.33983.camel@banks>
	 <1065428944.22491.169.camel@hades.cambridge.redhat.com>
	 <01f301c38f2f$b1a7e0b0$9602010a@jingle>
	 <1065791790.24015.238.camel@hades.cambridge.redhat.com>
	 <023501c38f32$2b83caa0$9602010a@jingle>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1065793144.24015.274.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Fri, 10 Oct 2003 14:39:04 +0100
Content-Transfer-Encoding: 8bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-10 at 15:26 +0200, Florian Schirmer wrote:
> The ethernet and wireless driver where never linked into the kernel.
>  So it should be okay if they only distribute the module.

That is true, according to the GPL, _only_ if the modules are
distributed as separate works. If they are part of a collective work
which is based on the kernel (note, not a _derived_ work but a
_collective_ work) then they must be released under the terms of the
GPL.

This is a _different_ issue to the question of whether a module is
indeed a derived work, and it's _far_ more clear-cut.

Ask yourself the following questions:

1. The wireless and Ethernet driver modules are distributed within
   a cramfs file system in a flash image on a chip soldered to the
   board of the device.

   Are they being distributed 'as separate works'?

2. The fundamental mode of operation of these devices is to
   receive network packets from one of the drivers, pass them
   through the Linux kernel routing or bridging code, and then
   back out through another of the network interfaces. All 
   three parts of this are indispensable and the product is 
   useless without any one part.

   A) Does this form a whole which is a derived work based on the
      Linux kernel?

   B) Does this form a whole which is a collective work?

   C) Is this collective work based, in part, on the Linux kernel?

3. Refer back to the facts in question 1. Is this 'mere aggregation
   of a work not based on the [kernel] on a volume of a storage or
   distribution medium'?

Now, having answered those questions, reread the final three paragraphs
of §2 of the GPL.

-- 
dwmw2

